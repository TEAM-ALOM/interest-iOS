//
//  WorkoutDataSource.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import Combine
import HealthKit

public protocol WorkoutDataSourceInterface {
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

public final class WorkoutDataSource: WorkoutDataSourceInterface {
    internal let manager: WorkoutManager
    
    public init(manager: WorkoutManager) {
        self.manager = manager
    }
    
    public func requestAuthorization() -> Bool {
        return manager.requestAuthorization()
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        manager.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        manager.subcribeCalorie(updateHandler: updateHandler)
    }
}
