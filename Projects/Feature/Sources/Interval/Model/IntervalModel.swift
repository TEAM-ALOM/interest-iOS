//
//  IntervalModel.swift
//  Presentation
//
//  Created by 송영모 on 11/12/23.
//

import Foundation
import Domain

public struct IntervalModel: Identifiable, Hashable {
    public var id: UUID
    
    public var title: String
    
    public var exerciseType: ExerciseTypeModel
    
    public var burningSecondTime: Int
    public var burningHeartIntervalType: HeartIntervalTypeModel
    public var restingSecondTime: Int
    public var restingHeartIntervalType: HeartIntervalTypeModel
    public var repeatCount: Int
    
    public var records: [IntervalRecordModel]
    
    public init(
        id: UUID = .init(),
        title: String = "",
        exerciseType: ExerciseTypeModel = .run,
        burningSecondTime: Int = 0,
        burningHeartIntervalType: HeartIntervalTypeModel = .three,
        restingSecondTime: Int = 0,
        restingHeartIntervalType: HeartIntervalTypeModel = .three,
        repeatCount: Int = 0,
        records: [IntervalRecordModel] = []
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
