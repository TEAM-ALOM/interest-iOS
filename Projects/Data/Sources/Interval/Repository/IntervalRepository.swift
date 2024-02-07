//
//  IntervalRepository.swift
//  Data
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

import Dependencies

import Domain

public final class IntervalRepository: IntervalRepositoryInterface {
    private let dataSource: IntervalDataSourceInterface
    
    public init(dataSource: IntervalDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    public func fetch(id: UUID) -> IntervalEntity? {
        return dataSource.fetch(id: id)?.toEntity()
    }
    
    public func fetches() -> [IntervalEntity] {
        return dataSource.fetches()
            .map {
                $0.toEntity()
            }
    }
    
    public func save(interval: IntervalEntity) -> Bool {
        return dataSource.save(
            title: interval.title, 
            exerciseType: interval.exerciseType.toPersistentModel(),
            repeatCount: interval.repeatCount,
            burningSecondTime: interval.burningSecondTime,
            burningHeartIntervalType: interval.burningHeartIntervalType.toPersistentModel(),
            restingSecondTime: interval.restingSecondTime,
            restingHeartIntervalType: interval.restingHeartIntervalType.toPersistentModel()
        )
    }
    
    public func update(at id: UUID, to interval: IntervalEntity) -> IntervalEntity? {
        return dataSource.update(
            at: id,
            title: interval.title, 
            exerciseType: interval.exerciseType.toPersistentModel(),
            repeatCount: interval.repeatCount,
            burningSecondTime: interval.burningSecondTime,
            burningHeartIntervalType: interval.burningHeartIntervalType.toPersistentModel(),
            restingSecondTime: interval.restingSecondTime,
            restingHeartIntervalType: interval.restingHeartIntervalType.toPersistentModel()
        )?.toEntity()
    }
    
    public func delete(at id: UUID) -> Bool {
        return dataSource.delete(at: id)
    }
}

extension IntervalRepository: TestDependencyKey {
    public static var testValue: IntervalRepository = unimplemented()
}

public extension DependencyValues {
    var intervalRepository: IntervalRepository {
        get { self[IntervalRepository.self] }
        set { self[IntervalRepository.self] = newValue }
    }
}

extension IntervalRepository {
    public static func live(dataSource: IntervalDataSourceInterface) -> Self {
        return Self(dataSource: dataSource)
    }
}

extension IntervalRepository: DependencyKey {
    public static var liveValue: IntervalRepository = .init(dataSource: DependencyValues.live.intervalDataSource)
}
