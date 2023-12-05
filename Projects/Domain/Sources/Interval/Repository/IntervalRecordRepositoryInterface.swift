//
//  IntervalRecordRepositoryInterface.swift
//  Domain
//
//  Created by 김도형 on 12/5/23.
//

import Foundation

public protocol IntervalRecordRepositoryInterface {
    func fetch(intervalID: UUID, at recordID: UUID) -> IntervalRecordEntity?
    func fetches(intervalID id: UUID) -> [IntervalRecordEntity]
    func append(intervalID: UUID, record: IntervalRecordEntity) -> IntervalRecordEntity
    func delete(intervalID: UUID, at recordID: UUID) -> Bool
}
