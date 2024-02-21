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
                if viewModel.isBurning {
                    let untilBurning = viewModel.totalTime - viewModel.activeTime
                    let burningTime = Double(viewModel.interval.burningSecondTime)
                    Color.burningColor
                        .opacity(0.2 * ((burningTime - untilBurning) / burningTime))
                } else {
                    let untilResting = viewModel.totalTime - viewModel.activeTime
                    let restingTime = Double(viewModel.interval.restingSecondTime)
                    Color.restColor
                        .opacity(0.2 * ((restingTime - untilResting) / restingTime))
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 8) {
                WatchIntervalChangeView(viewModel: $viewModel)
                
                WatchHealthInfoView(viewModel: $viewModel)
                
                Spacer()
            }
            .padding(.horizontal, 4)
        }
        .exerciseBackground(mode: viewModel.isBurning ? .burning : .rest)
        .animation(.smooth, value: viewModel.isBurning)
        .onAppear(perform: {
            viewModel.setupTimer()
        })
    }
}

#Preview {
    IntervalActiveWatchScreen(viewModel: .init(interval: .init(id: .init())))
}
