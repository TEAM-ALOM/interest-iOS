//
//  ExerciseTypeModel.swift
//  Presentation
//
//  Created by 최유경 on 1/7/24.
//

import Foundation

public enum ExerciseTypeModel: String, CaseIterable, Identifiable, Codable {
    case run = "figure.run"
    case cycle = "figure.outdoor.cycle"
    case swim = "figure.pool.swim"
    case stepper = "figure.stair.stepper"
    case badminton = "figure.badminton"
    
    public init?(value: String = "") {
        let tmp = ExerciseTypeModel(rawValue:value)
        if let out = tmp {
            self = out
            return
        }
        
        self = ExerciseTypeModel.run
    }
    public var id: Self { self }
}
