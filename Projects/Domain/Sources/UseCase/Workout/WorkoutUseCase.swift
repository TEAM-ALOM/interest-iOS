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

public final class WorkoutUseCase: WorkoutUseCaseInterface {
    internal let workoutRepository: WorkoutRepositoryInterface
    
    public init(workoutRepository: WorkoutRepositoryInterface) {
        self.workoutRepository = workoutRepository
    }
    
    public func requestAuthorization() -> Bool {
        return workoutRepository.requestAuthorization()
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        workoutRepository.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        workoutRepository.subcribeCalorie(updateHandler: updateHandler)
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
    
    public func workoutStartDate() -> Date? {
        return workoutRepository.workoutStartDate()
    }
    
    public func observeWorkoutState(updateHandler: @escaping (WorkoutState) -> Void) {
        workoutRepository.observeWorkoutState(updateHandler: updateHandler)
    }
    
    public func checkCurrentInterval() -> IntervalEntity? {
        return workoutRepository.checkCurrentInterval()
    }
}

