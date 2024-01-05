//
//  IntervalRecordRepository.swift
//  Data
//
//  Created by 김도형 on 12/5/23.
//

import Foundation
import Domain

public final class IntervalRecordRepository: IntervalRecordRepositoryInterface {
    private let dataSource: IntervalRecordDataSource
    
    public init(dataSource: IntervalRecordDataSource) {
        self.dataSource = dataSource
    }
    
    public func fetch(intervalId: UUID, at recordId: UUID) -> IntervalRecordEntity? {
        return dataSource.fetch(intervalId: intervalId, at: recordId)?.toEntity()
    }
    
    public func fetches(intervalId id: UUID) -> [IntervalRecordEntity] {
        return dataSource.fetches(intervalId: id).map { record in
            return record.toEntity()
        }
    }
    
    public func append(intervalId: UUID, record: IntervalRecordEntity) -> IntervalRecordEntity {
        return dataSource.append(
            intervalId: intervalId,
            heartRates: record.heartRates,
            repeatedCount: record.repeatedCount,
            secondTime: record.secondTime,
            createDate: record.createDate,
            calorie: record.calorie
        ).toEntity()
    }
    
    public func delete(intervalId: UUID, at recordId: UUID) -> Bool {
        return dataSource.delete(intervalId: intervalId, at: recordId)
    }
}
