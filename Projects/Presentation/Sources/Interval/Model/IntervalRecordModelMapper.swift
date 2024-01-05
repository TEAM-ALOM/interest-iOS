//
//  IntervalRecordModelMapper.swift
//  Presentation
//
//  Created by 김도형 on 12/30/23.
//

import Foundation
import Domain

struct IntervalRecordModelMapper {
    static func toPresentationModel(entity: IntervalRecordEntity) -> IntervalRecordModel {
        return .init(
            id: entity.id,
            heartRates: entity.heartRates,
            repeatedCount: entity.repeatedCount,
            secondTime: entity.secondTime,
            createDate: entity.createDate,
            calorie: entity.calorie
        )
    }
    
    static func toEntity(model: IntervalRecordModel) -> IntervalRecordEntity {
        return .init(
            id: model.id,
            heartRates: model.heartRates,
            repeatedCount: model.repeatedCount,
            secondTime: model.secondTime,
            createDate: model.createDate,
            calorie: model.calorie
        )
    }
}
