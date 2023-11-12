//
//  IntervalRepository.swift
//  Data
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import Domain

final class IntervalRepository: IntervalRepositoryInterface {
    private let dataSource: IntervalDataSourceInterface
    
    init(dataSource: IntervalDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    func fetchIntervals() -> [IntervalEntity] {
        return dataSource.fetchIntervals()
            .map {
                $0.toEntity()
            }
    }
}
