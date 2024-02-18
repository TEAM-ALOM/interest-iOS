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
    
    private var intervalEntity : IntervalEntity
    
    public init(
        router: IntervalRouter,
        intervalEntity : IntervalEntity
    ) {
        self.router = router
        self._intervalEntity = intervalEntity
        super.init(intervalItem: intervalEntity)
    }
    
    override func tapIntervalStartButton(intervalItem: IntervalEntity) {
        super.tapIntervalStartButton(intervalItem: intervalItem)
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: router)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
}

@Observable
public class IntervalDetailViewModel {
    var intervalItem: IntervalEntity
    
    public init(intervalItem: IntervalEntity) {
        self.intervalItem = intervalItem
    }
    
    func tapIntervalStartButton(intervalItem: IntervalEntity) {
        
    }
}
