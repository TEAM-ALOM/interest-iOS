//
//  WatchIntervalDataSource.swift
//  WatchData
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

public protocol WatchIntervalDataSourceInterface {
    func fetchIntervals() -> [WatchIntervalDTO]
}

public final class WatchIntervalDataSource: WatchIntervalDataSourceInterface {
    public init() {}
    
    public func fetchIntervals() -> [WatchIntervalDTO] {
        return WatchIntervalDTO.mocks
    }
}
