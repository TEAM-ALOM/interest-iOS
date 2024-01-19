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
    @ObservedObject var viewModel: IntervalListViewModelWithRouter
    
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
        .sheet(isPresented: $viewModel.showEditIntervalView, onDismiss: viewModel.fetchIntervalItems){
            viewModel.editIntervalScreen(selectedItem: viewModel.selectedItem!)
        }
        .onAppear {
            viewModel.fetchIntervalItems()
        }
    }
}
