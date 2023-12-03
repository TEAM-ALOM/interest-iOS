//
//  IntervalActiveViewModel+IntervalRouter.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation

import Domain

public class IntervalActiveViewModelWithRouter: IntervalActiveViewModel {
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
        router.triggerScreenTransition(route: .intervalActive)
    }
}

