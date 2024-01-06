//
//  HeartIntervalTypeModelMapper.swift
//  Presentation
//
//  Created by 김도형 on 1/2/24.
//

import Foundation
import Domain

public enum HeartIntervalTypeModelMapper {
    static func toPresentationModel(entity: HeartIntervalType) -> HeartIntervalTypeModel {
        switch entity {
        case .one:
            return .one
        case .two:
            return .two
        case .three:
            return .three
        case .four:
            return .four
        case .five:
            return .five
        }
    }
    
    static func toEntity(model: HeartIntervalTypeModel) -> HeartIntervalType {
        switch model {
        case .one:
            return .one
        case .two:
            return .two
        case .three:
            return .three
        case .four:
            return .four
        case .five:
            return .five
        }
    }
}
extension HeartSection {
    func toHeartIntervalType() -> HeartIntervalType {
        switch self {
        case .section1:
            return .one
        case .section2:
            return .two
        case .section3:
            return .three
        case .section4:
            return .four
        case .section5:
            return .five
        }
    }
}
