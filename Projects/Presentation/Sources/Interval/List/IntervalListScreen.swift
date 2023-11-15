//
//  IntervalListScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Domain
import SharedDesignSystem

public struct IntervalListScreen: View {
    @StateObject var viewModel: IntervalListViewModel
    
    public init(viewModel: IntervalListViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        ScrollView {
            Button(action: {
                viewModel.tapIntervalDetailPageButton()
            }, label: {
                Text("인터벌 상세페이지 가기")
            })
        }
    }
}
