//
//  DatePickerViewModel.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI

class DatePickerViewModel: ObservableObject {
    @Published var model: DatePickerModel

    init(model: DatePickerModel) {
        self.model = model
    }
}
