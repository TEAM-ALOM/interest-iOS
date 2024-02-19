//
//  IntervalDetailViewModel.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI

import Domain
import Dependencies

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
        
        intervalActiveViewModel.delegateActionHandler =  { [weak self] delegate in
            guard let `self` = self else { return }
            switch delegate {
            case let .saved(entity):
                self.interval.records.append(entity)
            }
        }
        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
}

@Observable
public class IntervalDetailViewModel {
    @ObservationIgnored @Dependency(\.intervalRecordUseCase) var intervalRecordUseCase
    
    var interval: IntervalEntity
    
    public init(interval: IntervalEntity) {
        self.interval = interval
    }
    
    func tapIntervalStartButton(interval: IntervalEntity) {
        
    }
    
    func fetchIntervalRecords(){
        self.interval.records = intervalRecordUseCase.fetchIntervalRecords(intervalId: interval.id)
    }
}
