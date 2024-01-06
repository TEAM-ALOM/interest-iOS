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
    
    public let title: String
    
    public var exerciseId: ExerciseImage.ID
    
    public var burningSecondTime: Int
    public var burningHeartIntervalType: HeartIntervalTypeModel
    public var restingSecondTime: Int
    public var restingHeartIntervalType: HeartIntervalTypeModel
    public var repeatCount: Int
    
    public var records: [IntervalRecordModel]
    
    public init(
        id: UUID,
        title: String = "",
        exerciseId : ExerciseImage.ID,
        burningSecondTime: Int = 0,
        burningHeartIntervalType: HeartIntervalTypeModel = .three,
        restingSecondTime: Int = 0,
        restingHeartIntervalType: HeartIntervalTypeModel = .three,
        repeatCount: Int = 0,
        records: [IntervalRecordModel] = []
    ) {
        self.id = id
        self.title = title
        self.exerciseId = exerciseId
        self.burningSecondTime = burningSecondTime
        self.burningHeartIntervalType = burningHeartIntervalType
        self.restingSecondTime = restingSecondTime
        self.restingHeartIntervalType = restingHeartIntervalType
        self.repeatCount = repeatCount
        self.records = records
    }
}

public extension IntervalModel {
    static var mocks: [IntervalModel] = [
        .init(
            id: .init(),
            title: "달리기 인터벌", 
            exerciseId: .run,
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .five,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            records: [
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                )
            ]
        ),
        .init(
            id: .init(),
            title: "자전거 인터벌", 
            exerciseId: .cycle,
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .five,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            records: [
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                )
            ]
        ),
        .init(
            id: .init(),
            title: "수영 인터벌",
            exerciseId: .swim,
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .five,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            records: [
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                )
            ]
        )
    ]
}
