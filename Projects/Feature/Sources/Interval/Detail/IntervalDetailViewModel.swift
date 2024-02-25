//
//  IntervalDetailViewModel.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI

import Domain
import SharedThirdPartyLib
import Dependencies
import Perception

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
    
    override func tapIntervalStartButton() {
        super.tapIntervalStartButton()
//        super.tapIntervalStartButton(interval: interval)
//        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: router, interval: interval)
//        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
//        
//        intervalActiveViewModel.delegateActionHandler = { [weak self] delegate in
//            guard let `self` = self else { return }
//            switch delegate {
//            case let .saved(entity):
//                self.interval.records.append(entity)
//            }
//        }
//        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
}

@Observable
public class IntervalDetailViewModel {
    @ObservationIgnored @Dependency(\.intervalRecordUseCase) var intervalRecordUseCase
    @ObservationIgnored @Dependency(\.workoutUseCase) var workoutUseCase
    @ObservationIgnored @Dependency(\.wcSessionUseCase) var wcSessionUseCase
    
    var interval: IntervalEntity
    
    public init(interval: IntervalEntity) {
        self.interval = interval
    }
    
    func tapIntervalStartButton() {
        workoutUseCase.startWorkout(interval: self.interval)
    }
    
    func fetchIntervalRecords() {
        self.interval.records = intervalRecordUseCase.fetchIntervalRecords(intervalId: interval.id)
    }
}
