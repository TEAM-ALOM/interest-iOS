//
//  HeartIntervalTypePresistentModel.swift
//  Domain
//
//  Created by 송영모 on 11/29/23.
//

import Foundation
import Domain

public enum HeartIntervalTypePresistentModel: Codable, CaseIterable, Equatable {
    case one
    case two
    case three
    case four
    case five
}

public extension HeartIntervalTypePresistentModel {
    func toEntity() -> HeartIntervalType {
        switch self {
        case .one: .one
        case .two: .two
        case .three: .three
        case .four: .four
        case .five: .five
        }
    }
}

public extension HeartIntervalType {
    func toPersistentModel() -> HeartIntervalTypePresistentModel {
        switch self {
        case .one: .one
        case .two: .two
        case .three: .three
        case .four: .four
        case .five: .five
        }
    }
}
