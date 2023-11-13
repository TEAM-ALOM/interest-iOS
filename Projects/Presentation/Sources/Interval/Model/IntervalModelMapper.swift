//
//  IntervalModelMapper.swift
//  Presentation
//
//  Created by 송영모 on 11/12/23.
//

import Foundation
import Domain

struct IntervalModelMapper {
    static func toPresentationModel(entity: IntervalEntity) -> IntervalItem {
        return .init(title: entity.title)
    }
}
