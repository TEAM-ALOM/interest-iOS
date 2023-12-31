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
    
    override func tapIntervalDetailPageButton(intervalModelID: UUID) {
        super.tapIntervalDetailPageButton(intervalModelID: intervalModelID)
        router.triggerScreenTransition(route: .intervalDetail(intervalModelID))
    }
}


public class IntervalListViewModel: ObservableObject {
    private let intervalUseCase: IntervalUseCaseInterface
    
    @Published var intervalItems: [IntervalModel] = []
    @Published var showEditIntervalView: Bool = false
    
    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func fetchIntervalItems() {
        // TODO: 실제 데이터 생성 이후에 사용
//        intervalItems = intervalUseCase.fetchIntervals().map {
//            IntervalModelMapper.toPresentationModel(entity: $0)
//        }
        intervalItems = IntervalModel.mocks
        
    }
    
    func tapStartButton() { }
    
    func tapIntervalDetailPageButton(intervalModelID: UUID) { }
    
    func tapIntervalEditButton() {
        showEditIntervalView = true
    }
}
