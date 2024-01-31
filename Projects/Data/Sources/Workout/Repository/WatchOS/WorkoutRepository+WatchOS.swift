//
//  WorkoutRepository+WatchOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(watchOS)
public extension WorkoutRepository {
    func startWorkout(workoutType: HKWorkoutActivityType) {
        dataSource.startWorkout(workoutType: workoutType)
    }
    
    func pauseWorkout() {
        dataSource.pauseWorkout()
    }
    
    func resumeWorkout() {
        dataSource.resumeWorkout()
    }
    
    func endWorkout() {
        dataSource.endWorkout()
    }
}
#endif
