//
//  AddEntity.swift
//  Presentation
//
//  Created by 최유경 on 1/6/24.
//

import Foundation

public enum ExerciseImage: String, CaseIterable, Identifiable, Codable {
    case run = "figure.run"
    case cycle = "figure.outdoor.cycle"
    case swim = "figure.pool.swim"
    case stepper = "figure.stair.stepper"
    case badminton = "figure.badminton"
    
    public init?(value: String = "") {
        let tmp = ExerciseImage(rawValue:value)
        if let out = tmp {
            self = out
            return
        }
        
        self = ExerciseImage.run
    }
    public var id: Self { self }
}
