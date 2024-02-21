//
//  IntervalListIPhoneScreen.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import Presentation
import SharedDesignSystem

public struct IntervalListIPhoneScreen: View {
    @State var viewModel: IntervalListViewModel
    
    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.intervals) { interval in
                    IntervalInfoCell(viewModel: viewModel, interval: interval)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 24)
            .onAppear() {
                viewModel.checkSessionState()
            }
        }
        .mainBackground()
        .onAppear {
            viewModel.fetchIntervalItems()
        }
    }
}
