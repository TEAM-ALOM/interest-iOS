//
//  IntervalUseCase.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

import Dependencies

public protocol IntervalUseCaseInterface {
    func fetch(id: UUID) -> IntervalEntity?
    func fetches() -> [IntervalEntity]
    @discardableResult func save(interval: IntervalEntity) -> Bool
    @discardableResult func update(at id: UUID, to interval: IntervalEntity) -> IntervalEntity?
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
    
    public func save(interval: IntervalEntity) -> Bool {
        return intervalRepository.save(interval: interval)
    }
    
    public func update(at id: UUID, to interval: IntervalEntity) -> IntervalEntity? {
        return intervalRepository.update(at: id, to: interval)
    }
    
    public func delete(at id: UUID) -> Bool {
        return intervalRepository.delete(at: id)
    }
}

extension IntervalUseCase: TestDependencyKey {
    public static var testValue: IntervalUseCase = unimplemented()
}

public extension DependencyValues {
    var intervalUseCase: IntervalUseCase {
        get { self[IntervalUseCase.self] }
        set { self[IntervalUseCase.self] = newValue }
    }
}

extension IntervalUseCase {
    public static func live(
        intervalRepository: IntervalRepositoryInterface
    ) -> Self {
        return Self(intervalRepository: intervalRepository)
    }
}
