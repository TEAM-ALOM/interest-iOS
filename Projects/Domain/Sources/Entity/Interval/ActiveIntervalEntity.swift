//
//  ActiveIntervalEntity.swift
//  Domain
//
//  Created by 김도형 on 2/25/24.
//

import Foundation

public struct ActiveIntervalEntity: Codable {
    public var currentIntervalType: ActiveIntervalType = .resting
    public var currentIntervalCount: Int = 0
    public var restingCount: Int = 1
    public var burningCount: Int = 0
    public var burningSecondTime: Int
    public var restingSecondTime: Int
    public var repeatCount: Int
    public var intervalId: UUID?
    public var intervalTitle: String
    public var burningHeartIntervalType: HeartIntervalType
    public var restingHeartIntervalType: HeartIntervalType
    public var startDate: Date
    
    public init(burningSecondTime: Int, 
                restingSecondTime: Int,
                repeatCount: Int,
                intervalId: UUID? = nil, 
                startDate: Date = .now,
                intervalTitle: String = "",
                burningHeartIntervalType: HeartIntervalType = .five,
                restingHeartIntervalType: HeartIntervalType = .two) {
        self.burningSecondTime = burningSecondTime
        self.restingSecondTime = restingSecondTime
        self.repeatCount = repeatCount
        self.intervalId = intervalId
        self.startDate = startDate
        self.intervalTitle = intervalTitle
        self.burningHeartIntervalType = burningHeartIntervalType
        self.restingHeartIntervalType = restingHeartIntervalType
    }
}

extension ActiveIntervalEntity {
    public enum ActiveIntervalType: Codable {
        case burning
        case resting
        
        public var systemImage: String {
            switch self {
            case .burning:
                return "flame.fill"
            case .resting:
                return "circle.hexagonpath.fill"
            }
        }
        
        public var text: String {
            switch self {
            case .burning:
                return "버닝"
            case .resting:
                return "휴식"
            }
        }
    }
}
