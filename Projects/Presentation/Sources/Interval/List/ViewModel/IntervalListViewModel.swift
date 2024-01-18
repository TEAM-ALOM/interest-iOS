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
    
    override func tapStartButton(intervalItem: IntervalModel) {
        super.tapStartButton(intervalItem: intervalItem)
        router.triggerScreenTransition(route: .intervalActive(intervalItem))
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
    
    @Published var selectedItem : IntervalModel = .init(id: UUID(), exerciseType: .run)
    
    public init(
        intervalUseCase: IntervalUseCaseInterface
        //selectedItem : IntervalModel
    ) {
        self.intervalUseCase = intervalUseCase
        //self.selectedItem = selectedItem
    }
    
    func fetchIntervalItems() {
        intervalItems = intervalUseCase.fetches().map {
            IntervalModelMapper.toPresentationModel(entity: $0)
        }
    }
    
    func tapStartButton(intervalItem: IntervalModel) { }
    
    func tapIntervalDetailPageButton(intervalItem: IntervalModel) { }
    
    func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
    }
    
    func tapIntervalEditButton() {
        showEditIntervalView = true
    }
}
