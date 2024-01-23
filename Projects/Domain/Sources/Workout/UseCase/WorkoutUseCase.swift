//
//  WorkoutUseCase.swift
//  Domain
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

public protocol WorkoutUseCaseInterface {
    func requestAuthorization() -> Bool
    func subcribeHeartRate(updateHandler: @escaping (Double) -> Void)
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void)
    
    #if os(iOS)
    func fetchHealthKitData(type: HKQuantityTypeIdentifier) async
    #elseif os(watchOS)
    func startWorkout(workoutType: HKWorkoutActivityType)
    func pauseWorkout()
    func resumeWorkout()
    func endWorkout()
    #endif
}

public final class WorkoutUseCase: WorkoutUseCaseInterface {
    internal let repository: WorkoutRepositoryInterface
    
    public init(repository: WorkoutRepositoryInterface) {
        self.repository = repository
    }
    
    public func requestAuthorization() -> Bool {
        return repository.requestAuthorization()
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        repository.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        repository.subcribeCalorie(updateHandler: updateHandler)
    }
}
