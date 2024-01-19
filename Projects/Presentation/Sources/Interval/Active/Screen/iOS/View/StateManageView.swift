//
//  StateManageView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI

struct StateManageView: View {
    @ObservedObject var viewModel: IntervalActiveViewModel
    @Binding var totalTime : Double

    var body: some View {
        Text(IntervalTimer(viewModel: viewModel, totalTime: $totalTime).calculateActiveTime)
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 16, design: .rounded))
    }
}

