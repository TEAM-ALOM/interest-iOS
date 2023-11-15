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
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase)
    }
    
    override func tapIntervalStartButton() {
        super.tapIntervalStartButton()
        router.triggerScreenTransition(route: .intervalDetail)
    }
}

public class IntervalDetailViewModel: ObservableObject {
    private let intervalUseCase: IntervalUseCaseInterface
    
    init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func tapIntervalStartButton() {
        
    }
}
