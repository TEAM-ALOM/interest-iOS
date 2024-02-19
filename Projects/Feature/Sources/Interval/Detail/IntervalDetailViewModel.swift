//
//  IntervalDetailViewModel.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI

import Domain

@Observable
public final class IntervalDetailViewModelWithRouter: IntervalDetailViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        interval : IntervalEntity
    ) {
        self.router = router
        super.init(interval: interval)
    }
    
    override func tapIntervalStartButton(interval: IntervalEntity) {
        super.tapIntervalStartButton(interval: interval)
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: router, interval: interval)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
}

@Observable
public class IntervalDetailViewModel {
    var interval: IntervalEntity
    
    public init(interval: IntervalEntity) {
        self.interval = interval
    }
    
    func tapIntervalStartButton(interval: IntervalEntity) {
        
    }
}
