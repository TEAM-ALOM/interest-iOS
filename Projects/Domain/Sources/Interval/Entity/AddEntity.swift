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

public struct RepeatCount {
    public var counts : Int
    
    public init(counts: Int) {
        self.counts = counts
    }
}

public struct Time {
    public var hours: Int
    public var minutes: Int
    public var seconds: Int
    
    public init(hours: Int, minutes: Int, seconds: Int) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}

public enum HeartSection: String, CaseIterable, Identifiable {
    case section1 = "1구간"
    case section2 = "2구간"
    case section3 = "3구간"
    case section4 = "4구간"
    case section5 = "5구간"
    
    public var id: Self { self }
}
