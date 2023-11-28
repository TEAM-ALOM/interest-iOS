//
//  WatchIntervalStateViewModel.swift
//  WatchPresentation
//
//  Created by 민지은 on 2023/11/28.
//

import Foundation

import WatchDomain

public class WatchIntervalStateViewModelWithRouter: WatchIntervalStateViewModel {
    private var router: WatchIntervalRouter
    
    public init(
        router: WatchIntervalRouter,
        intervalUseCase: WatchIntervalUseCaseInterface
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase)
    }
    
    override func addNewIntervalButton() {
        super.addNewIntervalButton()
        router.triggerScreenTransition(route: .addNewInterval)
    }
}

public class WatchIntervalStateViewModel: ObservableObject {
    private let intervalUseCase: WatchIntervalUseCaseInterface
    
    init(intervalUseCase: WatchIntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func addNewIntervalButton() {
        
    }
}
