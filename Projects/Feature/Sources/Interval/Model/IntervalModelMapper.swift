//
//  IntervalModelMapper.swift
//  Presentation
//
//  Created by 송영모 on 11/12/23.
//

import Foundation
import Domain

struct IntervalModelMapper {
    static func toPresentationModel(entity: IntervalEntity) -> IntervalModel {
        return .init(
            id: entity.id,
            title: entity.title, 
            exerciseType: ExerciseTypeModelMapper.toPresentationModel(entity: entity.exerciseType),
            burningSecondTime: entity.burningSecondTime,
            burningHeartIntervalType: HeartIntervalTypeModelMapper.toPresentationModel(
                entity: entity.burningHeartIntervalType
            ),
            restingSecondTime: entity.restingSecondTime,
            restingHeartIntervalType: HeartIntervalTypeModelMapper.toPresentationModel(
                entity: entity.restingHeartIntervalType
            ),
            repeatCount: entity.repeatCount,
            records: entity.records.map { record in
                IntervalRecordModelMapper.toPresentationModel(entity: record)
            }
        )
    }
    
    static func toEntity(model: IntervalModel) -> IntervalEntity {
        return .init(
            id: model.id,
            title: model.title, 
            exerciseType: ExerciseTypeModelMapper.toEntity(model: model.exerciseType),
            burningSecondTime: model.burningSecondTime,
            burningHeartIntervalType: HeartIntervalTypeModelMapper.toEntity(
                model: model.burningHeartIntervalType
            ),
            restingSecondTime: model.restingSecondTime,
            restingHeartIntervalType: HeartIntervalTypeModelMapper.toEntity(
                model: model.restingHeartIntervalType
            ),
            repeatCount: model.repeatCount,
            records: model.records.map { record in
                IntervalRecordModelMapper.toEntity(model: record)
            }
        )
    }
}
