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

public final class WorkoutUseCase: WorkoutUseCaseInterface {
    internal let workoutRepository: WorkoutRepositoryInterface
    
    public init(workoutRepository: WorkoutRepositoryInterface) {
        self.workoutRepository = workoutRepository
    }
    
    public func requestAuthorization() -> Bool {
        return workoutRepository.requestAuthorization()
    }
    
    public func startWorkout(configuration: HKWorkoutConfiguration) {
        workoutRepository.startWorkout(configuration: configuration)
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
    
    public func setWorkoutInterval(interval: IntervalEntity?) {
        workoutRepository.setWorkoutInterval(interval: interval)
    }
    
    public func getWorkoutInterval() -> IntervalEntity? {
        workoutRepository.getWorkoutInterval()
    }
    
    public func getWorkoutStartDate() -> Date? {
        workoutRepository.getWorkoutStartDate()
    }
    
    public func setWorkoutStartDate(date: Date?) {
        workoutRepository.setWorkoutStartDate(date: date)
    }
    
    public func unsubscribeWorkoutSessionInfo() {
        workoutRepository.unsubscribeWorkoutSessionInfo()
    }
}
