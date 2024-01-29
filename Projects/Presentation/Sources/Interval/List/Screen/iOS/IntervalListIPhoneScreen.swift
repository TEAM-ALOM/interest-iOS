//
//  IntervalListIPhoneScreen.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct IntervalListIPhoneScreen: View {
    @State var viewModel: IntervalListViewModel

    public var body: some View {
        ScrollView {
            LazyVStack(spacing: 24) {
                ForEach(viewModel.intervalItems) { item in
                    IntervalInfoCellView(intervalItem: item, intervalListViewModel: viewModel)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
        }
        .mainBackground()
        .onAppear {
            viewModel.fetchIntervalItems()
        }
    }
}
