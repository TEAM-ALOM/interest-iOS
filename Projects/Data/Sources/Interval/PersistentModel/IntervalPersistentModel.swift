//
//  IntervalPersistentModel.swift
//  Domain
//
//  Created by 송영모 on 11/28/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
public class IntervalPersistentModel {
    @Attribute(.unique) public let id: UUID = UUID()
    
    public var title: String = ""
    public var burningSecondTime: Int = 0
    public var burningHeartIntervalType: HeartIntervalTypePresistentModel = HeartIntervalTypePresistentModel.three
    public var restingSecondTime: Int = 0
    public var restingHeartIntervalType: HeartIntervalTypePresistentModel = HeartIntervalTypePresistentModel.three
    public var repeatCount: Int = 0
    
    @Relationship public var records: [IntervalRecordPersistentModel]? = []
    
    public init(
        title: String,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) {
        self.title = title
        self.repeatCount = repeatCount
        self.burningSecondTime = burningSecondTime
        self.burningHeartIntervalType = burningHeartIntervalType
        self.restingSecondTime = restingSecondTime
        self.restingHeartIntervalType = restingHeartIntervalType
    }
}

public extension IntervalPersistentModel {
    func toEntity() -> IntervalEntity {
        return .init(
            title: self.title,
            burningSecondTime: self.burningSecondTime,
            burningHeartIntervalType: self.burningHeartIntervalType.toEntity(),
            restingSecondTime: self.restingSecondTime,
            restingHeartIntervalType: self.restingHeartIntervalType.toEntity(),
            repeatCount: self.repeatCount,
            records: self.records?.map { $0.toEntity() } ?? []
        )
    }
}
