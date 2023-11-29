//
//  HeartIntervalTypePresistentModel.swift
//  Domain
//
//  Created by 송영모 on 11/29/23.
//

import Foundation

public enum HeartIntervalTypePresistentModel {
    case one
    case two
    case three
    case four
    case five
}

public extension HeartIntervalTypePresistentModel {
    func toEntity() -> HeartIntervalType {
        switch self {
        case .one: HeartIntervalType.one
        case .two: HeartIntervalType.two
        case .three: HeartIntervalType.three
        case .four: HeartIntervalType.four
        case .five: HeartIntervalType.five
        }
    }
}
