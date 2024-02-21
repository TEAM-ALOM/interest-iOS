//
//  WorkoutUseCase.swift
//  Domain
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

import Dependencies

public protocol WorkoutUseCaseInterface {
    func requestAuthorization() -> Bool
    func subcribeHeartRate(updateHandler: @escaping (Double) -> Void)
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void)
    
#if os(iOS)
    func fetchHealthKitData(type: HKQuantityTypeIdentifier) async
#endif
    func startWorkout(workoutType: HKWorkoutActivityType)
    func pauseWorkout()
    func resumeWorkout()
    func endWorkout()
}

public final class WorkoutUseCase: WorkoutUseCaseInterface {
    internal let workoutRepository: WorkoutRepositoryInterface
    
    public init(workoutRepository: WorkoutRepositoryInterface) {
        self.workoutRepository = workoutRepository
    }
    
    public func requestAuthorization() -> Bool {
        return workoutRepository.requestAuthorization()
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        workoutRepository.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        workoutRepository.subcribeCalorie(updateHandler: updateHandler)
    }
    
    public func startWorkout(workoutType: HKWorkoutActivityType) {
        workoutRepository.startWorkout(workoutType: workoutType)
    }
    
    public func pauseWorkout() {
        workoutRepository.pauseWorkout()
    }
    
    public func resumeWorkout() {
        workoutRepository.resumeWorkout()
    }
    
    public func endWorkout() {
        workoutRepository.endWorkout()
    }
}
