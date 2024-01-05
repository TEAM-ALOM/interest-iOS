//
//  IntervalRecordRepositoryInterface.swift
//  Domain
//
//  Created by 김도형 on 12/5/23.
//

import Foundation

public protocol IntervalRecordRepositoryInterface {
    func fetch(intervalId: UUID, at recordId: UUID) -> IntervalRecordEntity?
    func fetches(intervalId id: UUID) -> [IntervalRecordEntity]
    func append(intervalId: UUID, record: IntervalRecordEntity) -> IntervalRecordEntity
    func delete(intervalId: UUID, at recordId: UUID) -> Bool
}
