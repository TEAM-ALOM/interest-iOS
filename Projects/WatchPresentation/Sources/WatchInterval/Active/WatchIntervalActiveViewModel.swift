//
//  IntervalActiveViewModel.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

import WatchDomain

public class WatchIntervalActiveViewModelWithRouter: WatchIntervalActiveViewModel {
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

public class WatchIntervalActiveViewModel: ObservableObject {
    private let intervalUseCase: WatchIntervalUseCaseInterface
    
    @Published var activeTime: TimeInterval = 0
    
    init(intervalUseCase: WatchIntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func tapIntervalStartButton() {
        
    }
}
