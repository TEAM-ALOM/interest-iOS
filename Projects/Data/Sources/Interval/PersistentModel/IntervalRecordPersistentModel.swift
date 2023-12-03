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
    
    @Relationship public var interval: IntervalPersistentModel?
    
    public init(
        heartRates: [Double],
        repeatedCount: Int,
        secondTime: Int,
        interval: IntervalPersistentModel? = nil
    ) {
        self.heartRates = heartRates
        self.repeatedCount = repeatedCount
        self.secondTime = secondTime
        self.interval = interval
    }
}

public extension IntervalRecordPersistentModel {
    func toEntity() -> IntervalRecordEntity {
        return .init(
            heartRates: self.heartRates,
            repeatedCount: self.repeatedCount,
            secondTime: self.secondTime
        )
    }
}
