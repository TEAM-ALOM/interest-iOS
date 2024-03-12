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
        Group {
#if os(iOS)
            iOS
                .preferredColorScheme(.dark)
#elseif os(watchOS)
            watchOS
                .navigationBarBackButtonHidden()
#endif
        }
        .onAppear() {
            viewModel.subscribeReceivedMessage()
            viewModel.subscribeWorkoutSessionState()
            viewModel.setupTimer()
            viewModel.sendActiveInterval()
#if os(watchOS)
            viewModel.subscribeHeartRate()
            viewModel.subscribeCalorie()
#endif
        }
        .onDisappear() {
            viewModel.unsubscribeReceivedMessage()
            viewModel.unsubscribeWorkoutSessionInfo()
        }
    }
}

#Preview {
    IntervalActiveScreen(viewModel: .init(interval: .init(id: .init())))
}
