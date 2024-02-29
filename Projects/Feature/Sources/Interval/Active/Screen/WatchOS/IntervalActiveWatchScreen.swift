//
//  IntervalActiveScreenWithWatchOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct IntervalActiveWatchScreen: View {
    @State var viewModel: IntervalActiveViewModel
    
    @State private var isBounce = true
    @State private var timer: Timer?
    
    public var body: some View {
        ZStack {
            Group {
                switch viewModel.activeInterval.currentIntervalType {
                case .burning:
                    let burningTime = Double(viewModel.interval.burningSecondTime)
                    Color.burningColor
                        .opacity(0.2 * (Double(viewModel.currentSecondTime) / burningTime))
                case .resting:
                    let restingTime = Double(viewModel.interval.restingSecondTime)
                    Color.restColor
                        .opacity(0.2 * (Double(viewModel.currentSecondTime) / restingTime))
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 8) {
                WatchIntervalChangeView(viewModel: $viewModel)
                
                WatchHealthInfoView(viewModel: $viewModel)
                
                Spacer()
            }
        }
        .exerciseBackground(mode: viewModel.activeInterval.currentIntervalType == .burning ? .burning : .rest)
        .animation(.smooth, value: viewModel.activeInterval.currentIntervalType)
        .onAppear(perform: {
            viewModel.setupTimer()
        })
    }
}

#Preview {
    IntervalActiveWatchScreen(viewModel: .init(interval: .init(id: .init())))
}
