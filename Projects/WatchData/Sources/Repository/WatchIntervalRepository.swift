//
//  WatchIntervalRepository.swift
//  WatchData
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import WatchDomain

public final class WatchIntervalRepository: WatchIntervalRepositoryInterface {
    private let dataSource: WatchIntervalDataSourceInterface
    
    public init(dataSource: WatchIntervalDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    public func fetchIntervals() -> [WatchIntervalEntity] {
        return dataSource.fetchIntervals()
            .map {
                $0.toEntity()
            }
    }
}
