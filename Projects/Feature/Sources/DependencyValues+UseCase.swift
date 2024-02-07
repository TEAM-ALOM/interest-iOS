//
//  Composition.swift
//  Feature
//
//  Created by 송영모 on 2/3/24.
//

import Foundation

import Domain
import Data

import Dependencies

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
