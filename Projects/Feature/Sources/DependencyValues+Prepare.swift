//
//  Composition.swift
//  Feature
//
//  Created by 송영모 on 2/3/24.
//

import Foundation

import Data
import Domain

import SharedThirdPartyLib
import Dependencies

extension DependencyValues {
    public mutating func prepare() {
        let wcSessionManager = WCSessionManager()
        let workoutManager = WorkoutManager()
        
        let intervalDataSource = IntervalDataSource()
        let intervalRecordDataSource = IntervalRecordDataSource()
        let workoutDataSource = WorkoutDataSource(manager: workoutManager)
        let wcSessionDataSource = WCSessionDataSource(manager: wcSessionManager)
        
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalRecordRepository = IntervalRecordRepository(dataSource: intervalRecordDataSource)
        let workoutRepository = WorkoutRepository(dataSource: workoutDataSource)
        let wcSessionRepository = WCSessionRepository(dataSource: wcSessionDataSource)
        
        self.intervalUseCase = .init(intervalRepository: intervalRepository)
        self.intervalRecordUseCase = .init(intervalRecordRepository: intervalRecordRepository)
        self.workoutUseCase = .init(workoutRepository: workoutRepository)
        self.wcSessionUseCase = .init(wcSessionRepository: wcSessionRepository)
        
#if os(watchOS)
        self.watchWorkoutUseCase = .init()
#endif
    }
}
