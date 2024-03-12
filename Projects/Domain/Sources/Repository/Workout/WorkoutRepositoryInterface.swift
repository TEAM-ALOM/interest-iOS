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
