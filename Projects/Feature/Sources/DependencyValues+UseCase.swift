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
import Perception

extension IntervalUseCase: TestDependencyKey, DependencyKey {
    public static var testValue: IntervalUseCase = unimplemented()
    public static var liveValue: IntervalUseCase = .init(intervalRepository: DependencyValues.live.intervalRepository)
}

public extension DependencyValues {
    var intervalUseCase: IntervalUseCase {
        get { self[IntervalUseCase.self] }
        set { self[IntervalUseCase.self] = newValue }
    }
}

extension IntervalRecordUseCase: TestDependencyKey, DependencyKey {
    public static var testValue: IntervalRecordUseCase = unimplemented()
    public static var liveValue: IntervalRecordUseCase = .init(intervalRecordRepository: DependencyValues.live.intervalRecordRepository)
}

public extension DependencyValues {
    var intervalRecordUseCase: IntervalRecordUseCase {
        get { self[IntervalRecordUseCase.self] }
        set { self[IntervalRecordUseCase.self] = newValue }
    }
}

extension WorkoutUseCase: TestDependencyKey, DependencyKey {
    public static var testValue: WorkoutUseCase = unimplemented()
    public static var liveValue: WorkoutUseCase = .init(workoutRepository: DependencyValues.live.workoutRepository)
}

public extension DependencyValues {
    var workoutUseCase: WorkoutUseCase {
        get { self[WorkoutUseCase.self] }
        set { self[WorkoutUseCase.self] = newValue }
    }
}

extension WCSessionUseCase: TestDependencyKey, DependencyKey {
    public static var testValue: WCSessionUseCase = unimplemented()
    public static var liveValue: WCSessionUseCase = .init(wcSessionRepository: DependencyValues.live.wcSessionRepository)
}

public extension DependencyValues {
    var wcSessionUseCase: WCSessionUseCase {
        get { self[WCSessionUseCase.self] }
        set { self[WCSessionUseCase.self] = newValue }
    }
}
