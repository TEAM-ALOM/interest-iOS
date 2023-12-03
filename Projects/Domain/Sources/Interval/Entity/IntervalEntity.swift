//
//  IntervalEntity.swift
//  Domain
//
//  Created by 송영모 on 11/3/23.
//

import Foundation

public struct IntervalEntity {
    public let title: String
    
    public var burningSecondTime: Int
    public var burningHeartIntervalType: HeartIntervalType
    public var restingSecondTime: Int
    public var restingHeartIntervalType: HeartIntervalType
    public var repeatCount: Int
    
    public var records: [IntervalRecordEntity]
    
    public init(
        title: String = "",
        burningSecondTime: Int = 0,
        burningHeartIntervalType: HeartIntervalType = .three,
        restingSecondTime: Int = 0,
        restingHeartIntervalType: HeartIntervalType = .three,
        repeatCount: Int = 0,
        records: [IntervalRecordEntity] = []
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

extension IntervalEntity {
    static let mocks: [IntervalEntity] = [
        .init(title: "달리기 인터벌"),
        .init(title: "자전거 인터벌"),
        .init(title: "수영 인터벌"),
        .init(title: "천국의 계단 인터벌"),
        .init(title: "커스텀 인터벌"),
    ]
}
