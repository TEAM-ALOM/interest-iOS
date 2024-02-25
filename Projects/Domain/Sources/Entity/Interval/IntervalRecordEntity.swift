//
//  IntervalRecord.swift
//  Domain
//
//  Created by 송영모 on 11/29/23.
//

import Foundation

public struct IntervalRecordEntity: Identifiable, Codable {
    public var id: UUID
    
    public var heartRates: [Double] = []
    public var repeatedCount: Int = 0
    public var secondTime: Int = 0
    public var createDate: Date = .now
    public var calorie: Int = 0
    
    public init(
        id: UUID,
        heartRates: [Double],
        repeatedCount: Int,
        secondTime: Int,
        createDate: Date,
        calorie: Int
    ) {
        self.id = id
        self.heartRates = heartRates
        self.repeatedCount = repeatedCount
        self.secondTime = secondTime
        self.createDate = createDate
        self.calorie = calorie
    }
}

