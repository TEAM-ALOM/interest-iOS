//
//  WorkoutDataSource.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import Dependencies
import Domain

public protocol WorkoutDataSourceInterface {
    func requestAuthorization() -> Bool
    
#if os(watchOS)
    func sendActiveInfoData(_ activeInterval: ActiveIntervalEntity)
    func subcribeHeartRate(updateHandler: @escaping (Double) -> Void)
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void)
#elseif os(iOS)
    func subcribeActiveInterval(updateHandler: @escaping (ActiveIntervalEntity) -> Void)
    func workoutSessionMirroring(intervalId: UUID)
#endif
    func startWorkout(interval: IntervalEntity)
    func pauseWorkout()
    func resumeWorkout()
    func endWorkout()
    func subcribeWorkoutSessionState(updateHandler: @escaping (WorkoutSessionState) -> Void)
    func workoutIntervalId() -> UUID?
    func workoutStartDate() -> Date?
}

public final class WorkoutDataSource: WorkoutDataSourceInterface {
    internal let manager: WorkoutManager
    
    public init(manager: WorkoutManager) {
        self.manager = manager
    }
    
    public func requestAuthorization() -> Bool {
        return manager.requestAuthorization()
    }
    
    public func startWorkout(interval: IntervalEntity) {
        manager.startWorkout(workoutType: interval.exerciseType.hkWorkoutActivityType, intervalId: interval.id)
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
    
    public func subcribeWorkoutSessionState(updateHandler: @escaping (WorkoutSessionState) -> Void) {
        manager.subcribeWorkoutSessionState { state in
            switch state {
            case .notStarted:
                updateHandler(.notStarted)
            case .running:
                updateHandler(.running)
            case .ended:
                updateHandler(.ended)
            case .paused:
                updateHandler(.paused)
            case .prepared:
                updateHandler(.prepared)
            case .stopped:
                updateHandler(.stopped)
            @unknown default:
                print(state)
            }
        }
    }
    
    public func workoutIntervalId() -> UUID? {
        return manager.workoutIntervalId()
    }
    
    public func workoutStartDate() -> Date? {
        return manager.workoutStartDate()
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
