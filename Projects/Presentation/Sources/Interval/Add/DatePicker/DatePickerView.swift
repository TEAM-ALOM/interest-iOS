//
//  DatePickerView.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI

struct DatePickerModel {
    var selectedDate: Date
}

struct DatePickerView: View {
    @ObservedObject var viewModel: DatePickerViewModel

    var body: some View {
        DatePicker("Select Date", selection: $viewModel.model.selectedDate, displayedComponents: [.date, .hourAndMinute])
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
    }
}

#Preview {
    DatePickerView(viewModel: DatePickerViewModel(model: DatePickerModel(selectedDate: Date())))
}


