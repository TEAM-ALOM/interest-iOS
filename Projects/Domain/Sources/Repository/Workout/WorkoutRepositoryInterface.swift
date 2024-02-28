//
//  WorkoutRepositoryInterface.swift
//  Domain
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

public protocol WorkoutRepositoryInterface {
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
