//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Domain

public class IntervalListViewModelWithRouter: IntervalListViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase)
    }
    
    override func tapStartButton() {
        super.tapStartButton()
        router.triggerScreenTransition(route: .intervalActive)
    }
    
    override func tapIntervalDetailPageButton(intervalItem: IntervalModel) {
        super.tapIntervalDetailPageButton(intervalItem: intervalItem)
        router.triggerScreenTransition(route: .intervalDetail(intervalItem))
    }
}


public class IntervalListViewModel: ObservableObject {
    private let intervalUseCase: IntervalUseCaseInterface
    
    @Published var intervalItems: [IntervalModel] = []
    @Published var showEditIntervalView: Bool = false
    
    @Published var exercise : [ExerciseTypeModel] = ExerciseTypeModel.allCases
    @Published var selectedExerciseType: ExerciseTypeModel?
    
    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func fetchIntervalItems() {
        intervalItems = intervalUseCase.fetches().map {
            IntervalModelMapper.toPresentationModel(entity: $0)
        }
    }
    
    func tapStartButton() { }
    
    func tapIntervalDetailPageButton(intervalItem: IntervalModel) { }
    
    func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
    }
    
    func tapIntervalEditButton() {
        showEditIntervalView = true
    }
}
