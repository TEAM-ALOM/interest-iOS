//
//  ExerciseTypeModel.swift
//  Presentation
//
//  Created by 최유경 on 1/7/24.
//

import Foundation

public enum ExerciseTypeModel: CaseIterable {
    case run
    case cycle
    case swim
    case stepper
    case badminton
    
    public var systemImageName: String {
        switch self {
        case .run: "figure.run"
        case .cycle: "figure.outdoor.cycle"
        case .swim: "figure.pool.swim"
        case .stepper: "figure.stair.stepper"
        case .badminton: "figure.badminton"
        }
    }
}
