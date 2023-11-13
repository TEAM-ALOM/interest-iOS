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
    
    public func fetchIntervals() -> [IntervalEntity] {
        return dataSource.fetchIntervals()
            .map {
                $0.toEntity()
            }
    }
}
