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
import HealthKit

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
        
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: self.router, interval: interval)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        self.router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
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

    func tapIntervalStartButton(interval: IntervalEntity) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = interval.exerciseType.hkWorkoutActivityType
        workoutUseCase.setWorkoutInterval(interval: interval)
        workoutUseCase.startWorkout(configuration: configuration)
        #if os(iOS)
        workoutUseCase.workoutSessionMirroring()
        #endif
    }
    
    func fetchIntervalRecords(){
        self.interval.records = intervalRecordUseCase.fetchIntervalRecords(intervalId: interval.id)
    }
}
