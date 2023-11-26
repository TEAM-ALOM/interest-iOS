//
//  EditIntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

class EditIntervalViewModel: ObservableObject {
    
    @Published var burningSelectedInterval = Interval.section1
    @Published var burningTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    @Published var restSelectedInterval = Interval.section1
    @Published var restTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    
    @Published var name: String = ""
    
    init() {}
}

enum Interval: String, CaseIterable, Identifiable {
    case section1 = "1구간"
    case section2 = "2구간"
    case section3 = "3구간"
    case section4 = "4구간"
    case section5 = "5구간"
    
    var id: Self { self }
}

struct Time {
    var hours: Int
    var minutes: Int
    var seconds: Int
}
