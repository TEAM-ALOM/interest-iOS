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
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        dataSource.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        dataSource.subcribeCalorie(updateHandler: updateHandler)
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
    
    public func workoutStartDate() -> Date? {
        return dataSource.workoutStartDate()
    }
    
    public func observeWorkoutState(updateHandler: @escaping (WorkoutState) -> Void) {
        dataSource.observeWorkoutState(updateHandler: updateHandler)
    }
    
    public func checkCurrentInterval() -> IntervalEntity? {
        return dataSource.checkCurrentInterval()
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

