//
//  ExerciseTypeModel.swift
//  Data
//
//  Created by 최유경 on 1/7/24.
//

import Foundation
import Domain

public enum ExerciseTypeModelPersistentModel : String , Codable, CaseIterable, Equatable , Identifiable{
    case run = "figure.run"
    case cycle = "figure.outdoor.cycle"
    case swim = "figure.pool.swim"
    case stepper = "figure.stair.stepper"
    case badminton = "figure.badminton"
    
    public var id: Self { self }
}

public extension ExerciseTypeModelPersistentModel{
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
    func toPersistentModel() -> ExerciseTypeModelPersistentModel {
        switch self {
        case .run: .run
        case .cycle: .cycle
        case .swim: .swim
        case .stepper: .stepper
        case .badminton: .badminton
        }
    }
}
