//
//  EditIntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

class EditIntervalViewModel: ObservableObject {
    
    @Published var burningSelectedInterval = HeartSection.section1
    @Published var burningTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    @Published var restSelectedInterval = HeartSection.section1
    @Published var restTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    
    @Published var name: String = ""
    
    init() {}
}
