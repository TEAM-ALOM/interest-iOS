//
//  AddIntervalScreen.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI

struct AddIntervalScreen: View {
    @StateObject var viewModel: AddIntervalViewModel
    
    init(router: IntervalRouter) {
        self._viewModel = StateObject(wrappedValue: AddIntervalViewModel(router: router))
    }
    
    var body: some View {
        Text("인터벌 추가 페이지")
        
        DatePicker("Select Date", selection: $viewModel.date, displayedComponents: [.date, .hourAndMinute])
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
    }
    
}

#Preview {
    AddIntervalScreen(router: IntervalRouter())
}
