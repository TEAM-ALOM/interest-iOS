//
//  IntervalEntity.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

public struct IntervalEntity : Identifiable{
    public let id: UUID
    
    public var title: String
    public var exerciseType: ExerciseType
    
    public var burningSecondTime: Int
    public var burningHeartIntervalType: HeartIntervalType
    public var restingSecondTime: Int
    public var restingHeartIntervalType: HeartIntervalType
    public var repeatCount: Int
    
    public var records: [IntervalRecordEntity]
    
    public init(
        id: UUID,
        title: String = "",
        exerciseType: ExerciseType = .run,
        burningSecondTime: Int = 0,
        burningHeartIntervalType: HeartIntervalType = .three,
        restingSecondTime: Int = 0,
        restingHeartIntervalType: HeartIntervalType = .three,
        repeatCount: Int = 0,
        records: [IntervalRecordEntity] = []
    ) {
        self.id = id
        self.title = title
        self.exerciseType = exerciseType
        self.burningSecondTime = burningSecondTime
        self.burningHeartIntervalType = burningHeartIntervalType
        self.restingSecondTime = restingSecondTime
        self.restingHeartIntervalType = restingHeartIntervalType
        self.repeatCount = repeatCount
        self.records = records
    }
}
