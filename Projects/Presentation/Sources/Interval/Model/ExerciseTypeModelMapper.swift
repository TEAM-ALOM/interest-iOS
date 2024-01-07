//
//  ExerciseTypeModelMapper.swift
//  Presentation
//
//  Created by 최유경 on 1/7/24.
//

import Foundation
import Domain

public enum ExerciseTypeModelMapper{
    static func toPresentationModel(entity : ExerciseType) -> ExerciseTypeModel{
        switch entity{
        case .run :
            return .run
        case .cycle:
            return .cycle
        case .swim:
            return .swim
        case .stepper:
            return .stepper
        case .badminton:
            return .badminton
        }
    }
    
    static func toEntity(model : ExerciseTypeModel) -> ExerciseType{
        switch model {
        case .run:
            return .run
        case .cycle:
            return .cycle
        case .swim:
            return .swim
        case .stepper:
            return .stepper
        case .badminton:
            return .badminton
        }
    }
}
