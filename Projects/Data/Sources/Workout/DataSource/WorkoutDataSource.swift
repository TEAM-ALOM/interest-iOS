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
    func subcribeHeartRate(updateHandler: @escaping (Double) -> Void)
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void)
#if os(iOS)
    func observeActiveInfoData(updateHandler: @escaping (ActiveInfoEntity) -> Void)
#elseif os(watchOS)
    func sendActiveInfoData(_ activeInfo: ActiveInfoEntity)
#endif
    func startWorkout(interval: IntervalEntity)
    func pauseWorkout()
    func resumeWorkout()
    func endWorkout()
    func workoutStartDate() -> Date?
    func observeWorkoutState(updateHandler: @escaping (WorkoutState) -> Void)
    func checkCurrentInterval() -> IntervalEntity?
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
    
    public func startWorkout(interval: IntervalEntity) {
        do {
            let data = try JSONEncoder().encode(interval)
            manager.startWorkout(intervalData: data, workoutType: interval.exerciseType.workoutType)
        } catch {
            print(error)
        }
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
    
    public func workoutStartDate() -> Date? {
        return manager.workoutStartDate()
    }
    
    public func observeWorkoutState(updateHandler: @escaping (WorkoutState) -> Void) {
        manager.subscribeWorkoutState { state in
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
    
    public func checkCurrentInterval() -> IntervalEntity? {
        guard let intervalData = manager.intervalData else {
            return nil
        }
        do {
            let interval = try JSONDecoder().decode(IntervalEntity.self, from: intervalData)
            return interval
        } catch {
            print(error)
            return nil
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
