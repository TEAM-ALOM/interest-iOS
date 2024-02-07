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
        workoutRepository.startWorkout(workoutType: workoutType)
    }
    
    func pauseWorkout() {
        workoutRepository.pauseWorkout()
    }
    
    func resumeWorkout() {
        workoutRepository.resumeWorkout()
    }
    
    func endWorkout() {
        workoutRepository.endWorkout()
    }
}
#endif
