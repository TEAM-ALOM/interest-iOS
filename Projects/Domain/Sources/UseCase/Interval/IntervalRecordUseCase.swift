//
//  IntervalRecordUseCase.swift
//  Domain
//
//  Created by 김도형 on 12/5/23.
//

import Foundation

import Dependencies

public protocol IntervalRecordUseCaseInterface {
    func fetchIntervalRecord(intervalId: UUID, at recordId: UUID) -> IntervalRecordEntity?
    func fetchIntervalRecords(intervalId id: UUID) -> [IntervalRecordEntity]
    func appendIntervalRecord(intervalId: UUID, record: IntervalRecordEntity) -> Void
    func deleteIntervalRecord(intervalId: UUID, at recordId: UUID) -> Bool
}

public final class IntervalRecordUseCase: IntervalRecordUseCaseInterface {
    private let intervalRecordRepository: IntervalRecordRepositoryInterface
    
    public init(intervalRecordRepository: IntervalRecordRepositoryInterface) {
        self.intervalRecordRepository = intervalRecordRepository
    }
    
    public func fetchIntervalRecord(intervalId: UUID, at recordId: UUID) -> IntervalRecordEntity? {
        return intervalRecordRepository.fetch(intervalId: intervalId, at: recordId)
    }
    
    public func fetchIntervalRecords(intervalId id: UUID) -> [IntervalRecordEntity] {
        return intervalRecordRepository.fetches(intervalId: id)
    }
    
    public func appendIntervalRecord(intervalId: UUID, record: IntervalRecordEntity) -> Void {
        return intervalRecordRepository.append(intervalId: intervalId, record: record)
    }
    
    public func deleteIntervalRecord(intervalId: UUID, at recordId: UUID) -> Bool {
        return intervalRecordRepository.delete(intervalId: intervalId, at: recordId)
    }
}

extension IntervalRecordUseCase: TestDependencyKey {
    public static var testValue: IntervalRecordUseCase = unimplemented()
}

public extension DependencyValues {
    var intervalRecordUseCase: IntervalRecordUseCase {
        get { self[IntervalRecordUseCase.self] }
        set { self[IntervalRecordUseCase.self] = newValue }
    }
}

extension IntervalRecordUseCase {
    public static func live(
        intervalRecordRepository: IntervalRecordRepositoryInterface
    ) -> Self {
        return Self(intervalRecordRepository: intervalRecordRepository)
    }
}
