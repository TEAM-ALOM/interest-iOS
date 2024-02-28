//
//  WorkoutRepository.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

import Dependencies

import Domain

public final class WorkoutRepository: WorkoutRepositoryInterface {
    internal let dataSource: WorkoutDataSourceInterface
    
    public init(dataSource: WorkoutDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    public func requestAuthorization() -> Bool {
        return dataSource.requestAuthorization()
    }
    
    public func startWorkout(interval: IntervalEntity) {
        dataSource.startWorkout(interval: interval)
    }
    
    public func pauseWorkout() {
        dataSource.pauseWorkout()
    }
    
    public func resumeWorkout() {
        dataSource.resumeWorkout()
    }
    
    public func endWorkout() {
        dataSource.endWorkout()
    }
    
    public func subcribeWorkoutSessionState(updateHandler: @escaping (WorkoutSessionState) -> Void) {
        dataSource.subcribeWorkoutSessionState(updateHandler: updateHandler)
    }
    
    public func workoutIntervalId() -> UUID? {
        return dataSource.workoutIntervalId()
    }
    
    public func workoutStartDate() -> Date? {
        return dataSource.workoutStartDate()
    }
}

extension WorkoutRepository: TestDependencyKey {
    public static var testValue: WorkoutRepository = unimplemented()
}

public extension DependencyValues {
    var workoutRepository: WorkoutRepository {
        get { self[WorkoutRepository.self] }
        set { self[WorkoutRepository.self] = newValue }
    }
}

extension WorkoutRepository: DependencyKey {
    public static var liveValue: WorkoutRepository = .init(dataSource: DependencyValues.live.workoutDataSource)
}

