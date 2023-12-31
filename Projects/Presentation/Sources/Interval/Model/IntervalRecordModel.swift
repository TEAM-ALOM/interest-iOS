//
//  IntervalRecordModel.swift
//  Presentation
//
//  Created by 김도형 on 12/30/23.
//

import Foundation

public struct IntervalRecordModel: Identifiable {
    public var id: UUID = .init()
    
    public var heartRates: [Double] = []
    public var repeatedCount: Int = 0
    public var secondTime: Int = 0
    public var createDate: Date = .now
    public var calorie: Int = 0
    
    public init(
        heartRates: [Double],
        repeatedCount: Int,
        secondTime: Int,
        createDate: Date,
        calorie: Int
    ) {
        self.heartRates = heartRates
        self.repeatedCount = repeatedCount
        self.secondTime = secondTime
        self.createDate = createDate
        self.calorie = calorie
    }
}
