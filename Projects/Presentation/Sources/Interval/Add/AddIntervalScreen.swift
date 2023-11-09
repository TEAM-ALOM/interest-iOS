//
//  AddIntervalScreen.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI

struct AddIntervalScreen: View {
    @ObservedObject var viewModel: AddIntervalViewModel
    
    init(router: IntervalRouter) {
        self._viewModel = ObservedObject(wrappedValue: AddIntervalViewModel(router: router))
    }
    
    @State var date = Date()
    
    var body: some View {
        Text("인터벌 추가 페이지")
        
        DatePickerView(viewModel: DatePickerViewModel(model: DatePickerModel(selectedDate: Date())))
    }
    
}

#Preview {
    AddIntervalScreen(router: IntervalRouter())
}
