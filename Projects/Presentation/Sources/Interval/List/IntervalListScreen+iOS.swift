//
//  IntervalListScreen+iOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI

public extension IntervalListScreen {
    var iOS: some View {
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
        .background {
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.02, green: 0.7, blue: 1).opacity(0.2), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.02, green: 0.71, blue: 1).opacity(0), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea()
        }
        .sheet(isPresented: $viewModel.showEditIntervalView, content: {
            EditIntervalScreen()
        })
        .onAppear() {
            viewModel.fetchIntervalItems()
        }
    }
}
