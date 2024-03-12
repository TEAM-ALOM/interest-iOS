//
//  HeartIntervalType.swift
//  Domain
//
//  Created by 송영모 on 11/29/23.
//

import Foundation

public enum HeartIntervalType : CaseIterable, Codable {
    case one
    case two
    case three
    case four
    case five
    
    public var heartTypeName: String {
        switch self {
        case .one: "1구간"
        case .two: "2구간"
        case .three: "3구간"
        case .four: "4구간"
        case .five: "5구간"
        }
    }
    
    public var heartTypeValue: Int {
        switch self {
        case .one: 1
        case .two: 2
        case .three: 3
        case .four: 4
        case .five: 5
        }
    }
}
