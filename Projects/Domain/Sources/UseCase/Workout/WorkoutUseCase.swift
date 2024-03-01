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

public final class WorkoutUseCase: WorkoutUseCaseInterface {
    internal let workoutRepository: WorkoutRepositoryInterface
    
    public init(workoutRepository: WorkoutRepositoryInterface) {
        self.workoutRepository = workoutRepository
    }
    
    public func requestAuthorization() -> Bool {
        return workoutRepository.requestAuthorization()
    }
    
    public func startWorkout(interval: IntervalEntity) {
        workoutRepository.startWorkout(interval: interval)
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
    
    public func subcribeWorkoutSessionState(updateHandler: @escaping (WorkoutSessionState) -> Void) {
        workoutRepository.subcribeWorkoutSessionState(updateHandler: updateHandler)
    }
    
    public func workoutIntervalId() -> UUID? {
        return workoutRepository.workoutIntervalId()
    }
    
    public func workoutStartDate() -> Date? {
        return workoutRepository.workoutStartDate()
    }
}

extension WorkoutUseCase: TestDependencyKey {
    public static var testValue: WorkoutUseCase = unimplemented()
}

public extension DependencyValues {
    var workoutUseCase: WorkoutUseCase {
        get { self[WorkoutUseCase.self] }
        set { self[WorkoutUseCase.self] = newValue }
    }
}
