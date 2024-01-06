//
//  PickerModel.swift
//  Presentation
//
//  Created by 최유경 on 1/6/24.
//

import Foundation

enum ExerciseImage: String, CaseIterable, Identifiable {
    case run = "figure.run"
    case cycle = "figure.outdoor.cycle"
    case swim = "figure.pool.swim"
    case stepper = "figure.stair.stepper"
    case badminton = "figure.badminton"

    var id: Self { self }
}


struct RepeatCount {
    var counts : Int
}

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
}

enum HeartSection: String, CaseIterable, Identifiable {
    case section1 = "1구간"
    case section2 = "2구간"
    case section3 = "3구간"
    case section4 = "4구간"
    case section5 = "5구간"
    
    var id: Self { self }
}
