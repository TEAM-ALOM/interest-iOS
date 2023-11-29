//
//  IntervalRecord.swift
//  Domain
//
//  Created by 송영모 on 11/29/23.
//

import Foundation

public struct IntervalRecordEntity {
    public let id: UUID = UUID()
    
    public var heartRates: [Double] = []
    public var repeatedCount: Int = 0
    public var secondTime: Int = 0
    
    init(
        heartRates: [Double],
        repeatedCount: Int,
        secondTime: Int
    ) {
        self.heartRates = heartRates
        self.repeatedCount = repeatedCount
        self.secondTime = secondTime
    }
}

