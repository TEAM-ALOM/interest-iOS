//
//  IntervalEntity.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

public struct IntervalEntity: Identifiable {
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

public extension IntervalEntity {
    static var mocks: [IntervalEntity] = [
        .init(
            id: .init(),
            title: "달리기 인터벌",
            exerciseType: .run,
            burningSecondTime: 5,
            burningHeartIntervalType: .two,
            restingSecondTime: 3,
            restingHeartIntervalType: .one,
            repeatCount: 2,
            records: [
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
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
            exerciseType: .cycle,
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .three,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            repeatCount: 3,
            records: [
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
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
            exerciseType: .swim,
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .four,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            repeatCount: 2,
            records: [
                IntervalRecordEntity(
                    id: .init(),
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordEntity(
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
