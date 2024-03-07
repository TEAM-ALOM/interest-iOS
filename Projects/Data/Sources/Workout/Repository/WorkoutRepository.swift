//
//  WorkoutRepository.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import Dependencies
import Domain
import HealthKit

public final class WorkoutRepository: WorkoutRepositoryInterface {
    internal let dataSource: WorkoutDataSourceInterface
    
    public init(dataSource: WorkoutDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    public func requestAuthorization() -> Bool {
        return dataSource.requestAuthorization()
    }
    
    public func startWorkout(configuration: HKWorkoutConfiguration) {
        dataSource.startWorkout(configuration: configuration)
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

