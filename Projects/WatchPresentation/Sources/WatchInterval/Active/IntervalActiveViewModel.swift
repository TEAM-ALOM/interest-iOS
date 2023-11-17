//
//  IntervalActiveViewModel.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import WatchDomain

public class IntervalActiveViewModelWithRouter: IntervalActiveViewModel {
    private var router: WatchIntervalRouter
    
    public init(
        router: WatchIntervalRouter,
        intervalUseCase: WatchIntervalUseCaseInterface
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase)
    }
    
    override func tapIntervalStartButton() {
        super.tapIntervalStartButton()
        router.triggerScreenTransition(route: .intervalActive)
    }
}

public class IntervalActiveViewModel: ObservableObject {
    private let intervalUseCase: WatchIntervalUseCaseInterface
    
    init(intervalUseCase: WatchIntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func tapIntervalStartButton() {
        
    }
}
