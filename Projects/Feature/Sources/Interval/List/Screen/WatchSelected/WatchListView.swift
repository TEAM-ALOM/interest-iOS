//
//  WatchListView.swift
//  Presentation
//
//  Created by 최유경 on 1/18/24.
//

import Foundation
import SwiftUI

struct WatchListView: View {
    var viewModel: IntervalListViewModel
    
    var body : some View {
        WatchExercisePickerView(viewModel: viewModel)
            .onAppear() {
                viewModel.fetchIntervalItems()
                viewModel.observeIntervalMessage()
            }
    }
}
