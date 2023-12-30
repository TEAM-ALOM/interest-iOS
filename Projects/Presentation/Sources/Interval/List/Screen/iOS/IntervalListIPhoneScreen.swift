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
    @ObservedObject var viewModel: IntervalListViewModel
    
    public var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                ForEach(viewModel.intervalItems) { item in
                    IntervalInfoCellView(intervalItem: item, intervalListViewModel: viewModel)
                }
                
                Button(action: {
                    viewModel.tapIntervalDetailPageButton()
                }, label: {
                    Text("인터벌 상세페이지 가기")
                })
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
        }
        .mainBackground()
        .sheet(isPresented: $viewModel.showEditIntervalView, content: {
            EditIntervalScreen()
        })
        .onAppear() {
            viewModel.fetchIntervalItems()
        }
    }
}
