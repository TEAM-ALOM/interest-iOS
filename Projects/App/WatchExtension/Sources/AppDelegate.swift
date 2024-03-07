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
    
    func handle(_ workoutConfiguration: HKWorkoutConfiguration) {
        self.workoutUseCase.startWorkout(interval: <#T##IntervalEntity#>)
    }
}
