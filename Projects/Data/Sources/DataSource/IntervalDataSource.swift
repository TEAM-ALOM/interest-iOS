//
//  IntervalDataSource.swift
//  Data
//
//  Created by 송영모 on 11/12/23.
//

import Foundation

public protocol IntervalDataSourceInterface {
    func fetchIntervals() -> [IntervalDTO]
}

public final class IntervalDataSource: IntervalDataSourceInterface {
    public init() {}
    
    public func fetchIntervals() -> [IntervalDTO] {
        //TODO: 실제 데이터를 가져오는 로직을 추가해야함
        return IntervalDTO.mocks
    }
}
