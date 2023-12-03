//
//  IntervalRepositoryInterface.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

public protocol IntervalRepositoryInterface {
    func fetch(id: UUID) -> IntervalEntity?
    func fetches() -> [IntervalEntity]
    func save(interval: IntervalEntity) -> IntervalEntity
    func update(at id: UUID, to interval: IntervalEntity) -> IntervalEntity?
    func delete(at id: UUID) -> Bool
}
