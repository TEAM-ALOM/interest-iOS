//
//  IntervalRepository.swift
//  Data
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
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
    
    public func save(interval: IntervalEntity) -> IntervalEntity {
        return dataSource.save(
            title: interval.title, 
            exerciseType: interval.exerciseType.toPersistentModel(),
            repeatCount: interval.repeatCount,
            burningSecondTime: interval.burningSecondTime,
            burningHeartIntervalType: interval.burningHeartIntervalType.toPersistentModel(),
            restingSecondTime: interval.restingSecondTime,
            restingHeartIntervalType: interval.restingHeartIntervalType.toPersistentModel()
        ).toEntity()
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
