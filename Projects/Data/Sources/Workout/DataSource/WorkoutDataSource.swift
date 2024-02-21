//
//  WorkoutDataSource.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation

import Dependencies

import HealthKit

public protocol WorkoutDataSourceInterface {
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
    
    public func startWorkout(workoutType: HKWorkoutActivityType) {
        manager.startWorkout(workoutType: workoutType)
    }
    
    public func pauseWorkout() {
        manager.pauseWorkout()
    }
    
    public func resumeWorkout() {
        manager.resumeWorkout()
    }
    
    public func endWorkout() {
        manager.endWorkout()
    }
}

extension WorkoutDataSource: TestDependencyKey {
    public static var testValue: WorkoutDataSource = unimplemented()
}

public extension DependencyValues {
    var workoutDataSource: WorkoutDataSource {
        get { self[WorkoutDataSource.self] }
        set { self[WorkoutDataSource.self] = newValue }
    }
}

extension WorkoutDataSource: DependencyKey {
    public static var liveValue: WorkoutDataSource = .init(manager: .shared)
}
