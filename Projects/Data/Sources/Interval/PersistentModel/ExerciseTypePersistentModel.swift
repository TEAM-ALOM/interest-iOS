//
//  ExerciseTypeModel.swift
//  Data
//
//  Created by 최유경 on 1/7/24.
//

import Foundation
import Domain

public enum ExerciseTypePersistentModel: Codable {
    case run
    case cycle
    case swim
    case stepper
    case badminton
}

public extension ExerciseTypePersistentModel{
    func toEntity() -> ExerciseType {
        switch self {
        case .run: .run
        case .cycle: .cycle
        case .swim: .swim
        case .stepper: .stepper
        case .badminton: .badminton
        }
    }
}

public extension ExerciseType {
    func toPersistentModel() -> ExerciseTypePersistentModel {
        switch self {
        case .run: .run
        case .cycle: .cycle
        case .swim: .swim
        case .stepper: .stepper
        case .badminton: .badminton
        }
    }
}
