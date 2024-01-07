//
//  EditIntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI
import Domain

class EditIntervalViewModel: ObservableObject {
    
    @Published var burningSelectedInterval = HeartIntervalTypeModel.one
    @Published var burningTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    @Published var restSelectedInterval = HeartIntervalTypeModel.one
    @Published var restTime: Time = .init(hours: 0, minutes: 0, seconds: 0)
    
    @Published var name: String = ""
    
    init() {}
}
