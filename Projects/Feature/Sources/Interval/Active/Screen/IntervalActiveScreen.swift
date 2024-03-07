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
                .onAppear() {
                    viewModel.subscribeHeartRate()
                    viewModel.subscribeCalorie()
                }
#endif
        }
        .onAppear() {
            viewModel.subscribeWorkoutSessionState()
            viewModel.subscribeReceivedMessage()
        }
        .onDisappear() {
            viewModel.timerPublisherCancel()
            viewModel.unsubscribeReceivedMessage()
        }
    }
}

#Preview {
    IntervalActiveScreen(viewModel: .init(interval: .init(id: .init())))
}
