//
//  AppDelegate.swift
//  InterestApp
//
//  Created by 김도형 on 2/23/24.
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
    @Dependency(\.wcSessionUseCase) var wcSessionUseCase
    @Dependency(\.intervalUseCase) var intervalUseCase
    
    func handle(_ workoutConfiguration: HKWorkoutConfiguration) {
        print(#function)
        wcSessionUseCase.sendMessage(["WORKOUT_READY_WATCH": true])
        
        wcSessionUseCase.observeReceiveMessageValue(key: "INTERVAL_ID") { [weak self] (id: String) in
            guard let `self` = self else { return }
            self.workoutUseCase.startWorkout(interval: .init(id: UUID(uuidString: id)!))
        }
    }
}
