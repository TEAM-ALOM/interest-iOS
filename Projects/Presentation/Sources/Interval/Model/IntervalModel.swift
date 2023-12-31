//
//  IntervalModel.swift
//  Presentation
//
//  Created by 송영모 on 11/12/23.
//

import Foundation

public struct IntervalModel: Identifiable {
    public var id: UUID = .init()
    
    public let title: String
    
    public var burningSecondTime: Int
    public var burningHeartIntervalType: HeartIntervalTypeModel
    public var restingSecondTime: Int
    public var restingHeartIntervalType: HeartIntervalTypeModel
    public var repeatCount: Int
    
    public var records: [IntervalRecordModel]
    
    public init(
        title: String = "",
        burningSecondTime: Int = 0,
        burningHeartIntervalType: HeartIntervalTypeModel = .three,
        restingSecondTime: Int = 0,
        restingHeartIntervalType: HeartIntervalTypeModel = .three,
        repeatCount: Int = 0,
        records: [IntervalRecordModel] = []
    ) {
        self.title = title
        self.burningSecondTime = burningSecondTime
        self.burningHeartIntervalType = burningHeartIntervalType
        self.restingSecondTime = restingSecondTime
        self.restingHeartIntervalType = restingHeartIntervalType
        self.repeatCount = repeatCount
        self.records = records
    }
}

public extension IntervalModel {
    static let mocks: [IntervalModel] = [
        .init(
            title: "달리기 인터벌",
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .five,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            records: [
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                )
            ]
        ),
        .init(
            title: "자전거 인터벌",
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .five,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            records: [
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                )
            ]
        ),
        .init(
            title: "수영 인터벌",
            burningSecondTime: 1 * 60,
            burningHeartIntervalType: .five,
            restingSecondTime: 4 * 60,
            restingHeartIntervalType: .one,
            records: [
                IntervalRecordModel(
                    heartRates: [136],
                    repeatedCount: 6,
                    secondTime: 38 * 60,
                    createDate: .now,
                    calorie: 605
                ),
                IntervalRecordModel(
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
