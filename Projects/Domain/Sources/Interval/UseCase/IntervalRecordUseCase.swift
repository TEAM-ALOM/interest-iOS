//
//  IntervalRecordUseCase.swift
//  Domain
//
//  Created by 김도형 on 12/5/23.
//

import Foundation

public protocol IntervalRecordUseCaseInterface {
    func fetchIntervalRecord(intervalID: UUID, at recordID: UUID) -> IntervalRecordEntity?
    func fetchIntervalRecords(intervalID id: UUID) -> [IntervalRecordEntity]
    func appendIntervalRecord(intervalID: UUID, record: IntervalRecordEntity) -> IntervalRecordEntity
    func deleteIntervalRecord(intervalID: UUID, at recordID: UUID) -> Bool
}

public final class IntervalRecordUseCase: IntervalRecordUseCaseInterface {
    private let intervalRecordRepository: IntervalRecordRepositoryInterface
    
    init(intervalRecordRepository: IntervalRecordRepositoryInterface) {
        self.intervalRecordRepository = intervalRecordRepository
    }
    
    public func fetchIntervalRecord(intervalID: UUID, at recordID: UUID) -> IntervalRecordEntity? {
        return intervalRecordRepository.fetch(intervalID: intervalID, at: recordID)
    }
    
    public func fetchIntervalRecords(intervalID id: UUID) -> [IntervalRecordEntity] {
        return intervalRecordRepository.fetches(intervalID: id)
    }
    
    public func appendIntervalRecord(intervalID: UUID, record: IntervalRecordEntity) -> IntervalRecordEntity {
        return intervalRecordRepository.append(intervalID: intervalID, record: record)
    }
    
    public func deleteIntervalRecord(intervalID: UUID, at recordID: UUID) -> Bool {
        return intervalRecordRepository.delete(intervalID: intervalID, at: recordID)
    }
}
