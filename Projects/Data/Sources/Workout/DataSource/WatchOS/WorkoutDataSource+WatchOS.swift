//
//  WorkoutDataSource+WatchOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(watchOS)
public extension WorkoutDataSource {
    func startWorkout(workoutType: HKWorkoutActivityType) {
        manager.startWorkout(workoutType: workoutType)
    }
    
    func pauseWorkout() {
        manager.pauseWorkout()
    }
    
    func resumeWorkout() {
        manager.resumeWorkout()
    }
    
    func endWorkout() {
        manager.endWorkout()
    }
}
#endif
