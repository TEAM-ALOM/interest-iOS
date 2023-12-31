//
//  IntervalDetailViewModel.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI

import Domain

public class IntervalDetailViewModelWithRouter: IntervalDetailViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalRecordUseCase: IntervalRecordUseCaseInterface,
        intervalItem: IntervalModel
    ) {
        self.router = router
        super.init(
            intervalRecordUseCase: intervalRecordUseCase,
            intervalItem: intervalItem
        )
    }
    
    override func tapIntervalStartButton() {
        super.tapIntervalStartButton()
//        router.triggerScreenTransition(route: .intervalDetail())
    }
}

public class IntervalDetailViewModel: ObservableObject {
    @Published var intervalItem: IntervalModel
    
    private let intervalRecordUseCase: IntervalRecordUseCaseInterface
    
    init(
        intervalRecordUseCase: IntervalRecordUseCaseInterface,
        intervalItem: IntervalModel
    ) {
        self.intervalRecordUseCase = intervalRecordUseCase
        self.intervalItem = intervalItem
    }
    
    func tapIntervalStartButton() {
        
    }
}
