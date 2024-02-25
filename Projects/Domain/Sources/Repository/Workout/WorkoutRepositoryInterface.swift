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
