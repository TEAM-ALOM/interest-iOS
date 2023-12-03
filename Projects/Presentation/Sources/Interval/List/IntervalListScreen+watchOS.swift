//
//  IntervalListScreen+watchOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation

import SwiftUI

public extension IntervalListScreen {
    var watchOS: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 24) {
                ForEach(viewModel.intervalItems) { item in
                    //TODO: 셀로 변경 해야함
                    Text(item.title)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 32)
        }
        .onAppear() {
            viewModel.fetchIntervalItems()
        }
    }
}
