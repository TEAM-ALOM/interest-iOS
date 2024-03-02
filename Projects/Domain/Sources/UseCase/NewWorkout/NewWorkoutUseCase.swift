//
//  NewWorkoutUseCase.swift
//  Domain
//
//  Created by 송영모 on 3/2/24.
//

import Foundation

import Dependencies
import Shared

public protocol NewWorkoutUseCaseInterface {
    func requestAuthorization()
    
    func subcribeHeartRate(updateHandler: @escaping (Double) -> Void)
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void)
}

public final class NewWorkoutUseCase: NewWorkoutUseCaseInterface {
    private let store: HealthKitStore
    private let intervalRecordRepository: IntervalRecordRepositoryInterface
    
    public init(
        store: HealthKitStore,
        intervalRecordRepository: IntervalRecordRepositoryInterface
    ) {
        self.store = store
        self.intervalRecordRepository = intervalRecordRepository
    }
    
    public func requestAuthorization() {
        store.requestAuthorization { _, _ in }
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        
    }
}

extension NewWorkoutUseCase: TestDependencyKey {
    public static var testValue: NewWorkoutUseCase = unimplemented()
}

public extension DependencyValues {
    var newWorkoutUseCase: NewWorkoutUseCase {
        get { self[NewWorkoutUseCase.self] }
        set { self[NewWorkoutUseCase.self] = newValue }
    }
}
