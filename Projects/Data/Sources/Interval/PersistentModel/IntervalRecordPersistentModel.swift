//
//  IntervalRecordPersistentModel.swift
//  Domain
//
//  Created by 송영모 on 11/29/23.
//

import Foundation
import SwiftData
import SwiftUI
import Domain

@Model
public class IntervalRecordPersistentModel {
    @Attribute(.unique) public let id: UUID = UUID()
    
    public var heartRates: [Double] = []
    public var repeatedCount: Int = 0
    public var secondTime: Int = 0
    public var createDate: Date = Date.now
    public var calorie: Int = 0
    
    @Relationship(inverse: \IntervalPersistentModel.records)
    public var interval: IntervalPersistentModel?
    
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

public extension IntervalRecordPersistentModel {
    func toEntity() -> IntervalRecordEntity {
        return .init(
            id: self.id,
            heartRates: self.heartRates,
            repeatedCount: self.repeatedCount,
            secondTime: self.secondTime,
            createDate: self.createDate,
            calorie: self.calorie
        )
    }
}
