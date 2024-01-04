//
//  IntervalUseCase.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import Combine

public protocol IntervalUseCaseInterface {
    func fetch(id: UUID) -> IntervalEntity?
    func fetches() -> [IntervalEntity]
    func save(interval: IntervalEntity) -> IntervalEntity
    func update(at id: UUID, to interval: IntervalEntity) -> IntervalEntity?
    func delete(at id: UUID) -> Bool
}

public final class IntervalUseCase: IntervalUseCaseInterface {
    private let intervalRepository: IntervalRepositoryInterface
    
    public init(intervalRepository: IntervalRepositoryInterface) {
        self.intervalRepository = intervalRepository
    }
    
    public func fetch(id: UUID) -> IntervalEntity? {
        return intervalRepository.fetch(id: id)
    }
    
    public func fetches() -> [IntervalEntity] {
        return intervalRepository.fetches()
    }
    
    public func save(interval: IntervalEntity) -> IntervalEntity {
        return intervalRepository.save(interval: interval)
    }
    
    public func update(at id: UUID, to interval: IntervalEntity) -> IntervalEntity? {
        return intervalRepository.update(at: id, to: interval)
    }
    
    public func delete(at id: UUID) -> Bool {
        return intervalRepository.delete(at: id)
    }
}
