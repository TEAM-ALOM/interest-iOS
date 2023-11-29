//
//  IntervalUseCase.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import Combine

public protocol IntervalUseCaseInterface {
    func fetchInterval(id: UUID) -> IntervalEntity?
    func fetchIntervals() -> [IntervalEntity]
    func saveInterval(interval: IntervalEntity) -> IntervalEntity
    func updateInterval(at id: UUID, to interval: IntervalEntity) -> IntervalEntity?
    func deleteInterval(at id: UUID) -> Bool
}

public final class IntervalUseCase: IntervalUseCaseInterface {
    private let intervalRepository: IntervalRepositoryInterface
    
    public init(intervalRepository: IntervalRepositoryInterface) {
        self.intervalRepository = intervalRepository
    }
    
    public func fetchInterval(id: UUID) -> IntervalEntity? {
        return intervalRepository.fetch(id: id)
    }
    
    public func fetchIntervals() -> [IntervalEntity] {
        return intervalRepository.fetches()
    }
    
    public func saveInterval(interval: IntervalEntity) -> IntervalEntity {
        return intervalRepository.save(interval: interval)
    }
    
    public func updateInterval(at id: UUID, to interval: IntervalEntity) -> IntervalEntity? {
        return intervalRepository.update(at: id, to: interval)
    }
    
    public func deleteInterval(at id: UUID) -> Bool {
        return intervalRepository.delete(at: id)
    }
}
