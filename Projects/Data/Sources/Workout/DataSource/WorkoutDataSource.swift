//
//  WorkoutDataSource.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import Dependencies
import HealthKit
import Domain

public protocol WorkoutDataSourceInterface {
    func requestAuthorization() -> Bool
    
#if os(watchOS)
    func sendActiveInfoData(_ activeInterval: ActiveIntervalEntity)
    func subcribeHeartRate(updateHandler: @escaping (Double) -> Void)
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void)
#elseif os(iOS)
    func workoutSessionMirroring()
#endif
    func startWorkout(configuration: HKWorkoutConfiguration)
    func pauseWorkout()
    func resumeWorkout()
    func endWorkout()
    func subcribeWorkoutSessionState(updateHandler: @escaping (WorkoutSessionState) -> Void)
    func setWorkoutInterval(interval: IntervalEntity?)
    func getWorkoutInterval() -> IntervalEntity?
    func getWorkoutStartDate() -> Date?
    func setWorkoutStartDate(date: Date?)
    func unsubscribeWorkoutSessionInfo()
}

public final class WorkoutDataSource: WorkoutDataSourceInterface {
    internal let manager: WorkoutManager
    
    public init(manager: WorkoutManager) {
        self.manager = manager
    }
    
    public func requestAuthorization() -> Bool {
        return manager.requestAuthorization()
    }
    
    public func startWorkout(configuration: HKWorkoutConfiguration) {
        manager.startWorkout(configuration: configuration)
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
    
    public func setWorkoutInterval(interval: IntervalEntity?) {
        manager.interval = interval as Any
    }
    
    public func getWorkoutInterval() -> IntervalEntity? {
        return manager.interval as? IntervalEntity
    }
    
    public func getWorkoutStartDate() -> Date? {
        return manager.startDate
    }
    
    public func setWorkoutStartDate(date: Date?) {
        manager.startDate = date
    }
    
    public func unsubscribeWorkoutSessionInfo() {
        manager.unsubscribeWorkoutSessionInfo()
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
