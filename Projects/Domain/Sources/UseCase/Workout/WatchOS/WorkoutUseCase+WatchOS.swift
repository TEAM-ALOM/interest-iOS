//
//  WorkoutUseCase+WatchOS.swift
//  Domain
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(watchOS)
public extension WorkoutUseCase {
    func startWorkout(workoutType: HKWorkoutActivityType) {
        repository.startWorkout(workoutType: workoutType)
    }
    
    func pauseWorkout() {
        repository.pauseWorkout()
    }
    
    func resumeWorkout() {
        repository.resumeWorkout()
    }
    
    func endWorkout() {
        repository.endWorkout()
    }
}
#endif
