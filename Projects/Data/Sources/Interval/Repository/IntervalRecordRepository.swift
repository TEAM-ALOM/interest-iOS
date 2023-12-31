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
    
    public func fetch(intervalID: UUID, at recordID: UUID) -> IntervalRecordEntity? {
        return dataSource.fetch(intervalID: intervalID, at: recordID)?.toEntity()
    }
    
    public func fetches(intervalID id: UUID) -> [IntervalRecordEntity] {
        return dataSource.fetches(intervalID: id).map { record in
            return record.toEntity()
        }
    }
    
    public func append(intervalID: UUID, record: IntervalRecordEntity) -> IntervalRecordEntity {
        return dataSource.append(
            intervalID: intervalID,
            heartRates: record.heartRates,
            repeatedCount: record.repeatedCount,
            secondTime: record.secondTime,
            createDate: record.createDate,
            calorie: record.calorie
        ).toEntity()
    }
    
    public func delete(intervalID: UUID, at recordID: UUID) -> Bool {
        return dataSource.delete(intervalID: intervalID, at: recordID)
    }
}
