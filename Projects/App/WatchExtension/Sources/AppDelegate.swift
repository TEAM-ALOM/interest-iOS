//
//  AppDelegate.swift
//  InterestWatchExtension
//
//  Created by 김도형 on 2/26/24.
//

import Foundation
import WatchKit
import HealthKit
import Feature
import Domain
import Dependencies
import Perception

class AppDelegate: NSObject, WKApplicationDelegate, WKExtensionDelegate {
    @Dependency(\.workoutUseCase) var workoutUseCase
    
    let intervalRouter: IntervalRouter
    
    override init() {
        self.intervalRouter = .init()
    }
    
    func handle(_ workoutConfiguration: HKWorkoutConfiguration) {
        self.workoutUseCase.startWorkout(configuration: workoutConfiguration)
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: self.intervalRouter, interval: self.workoutUseCase.getWorkoutInterval())
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        self.intervalRouter.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
}
