//
//  IntervalActiveScreen.swift
//  WatchPresentation
//
//  Created by 민지은 on 2023/11/28.
//
import Foundation
import SwiftUI

import Domain
import Shared
import SharedDesignSystem

public struct IntervalActiveScreen: View {
    @State var viewModel: IntervalActiveViewModel
    
    public init(viewModel: IntervalActiveViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
#if os(iOS)
        iOS
            .preferredColorScheme(.dark)
            .onAppear() {
                viewModel.subcribeHeartRate()
                viewModel.subscibeCalorie()
                viewModel.subscribeActiveInfoData()
            }
#elseif os(watchOS)
        watchOS
            .navigationBarBackButtonHidden()
            .onAppear {
                viewModel.subcribeHeartRate()
                viewModel.subscibeCalorie()
            }
#endif
    }
}

#Preview {
    IntervalActiveScreen(viewModel: .init(interval: .init(id: .init())))
}
