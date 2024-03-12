//
//  IntervalActiveScreenWithiPhone.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct IntervalActiveIPhoneScreen: View {
    @State var viewModel: IntervalActiveViewModel
    
    public var body: some View {
        ZStack {
            Group {
                switch viewModel.activeInterval.currentIntervalType {
                case .burning:
                    let burningTime = Double(viewModel.activeInterval.burningSecondTime)
                    Color.burningColor
                        .opacity(0.2 * (Double(viewModel.currentSecondTime) / burningTime))
                case .resting:
                    let restingTime = Double(viewModel.activeInterval.restingSecondTime)
                    Color.restColor
                        .opacity(0.2 * (Double(viewModel.currentSecondTime) / restingTime))
                }
            }
            .ignoresSafeArea()
            
            VStack(spacing: 40) {
                IntervalChangeView(viewModel: $viewModel)
                
                HealthInfoView(viewModel: $viewModel)
                
                StateManageView(viewModel: $viewModel)
                
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle(viewModel.activeInterval.intervalTitle)
        .navigationBarTitleDisplayMode(.inline)
        .exerciseBackground(mode: viewModel.activeInterval.currentIntervalType == .burning ? .burning : .rest)
        .animation(.smooth, value: viewModel.activeInterval.currentIntervalType)
        .overlay(alignment: .bottom) {
            stateButton(isPause: true, action: viewModel.tapPauseButton)
        }
        .overlay(alignment: .bottomTrailing){
            stateButton(isPause: false, action: viewModel.tapEndButton)
                .padding(.trailing, 36)
        }
    }
    
    @ViewBuilder
    func stateButton(isPause : Bool, action: @escaping () -> Void) -> some View {
        Button(action: action, label: {
            ZStack{
                Circle()
                    .fill(isPause ? Color.noticeColor25 : Color.warningColor25)
                    .frame(width: isPause ? 100 : 80, height: isPause ? 100 : 80)
                
                Image(systemName: isPause ? "pause.fill" : "xmark")
                    .resizable()
                    .frame(width: isPause ? 35 : 25 , height: isPause ? 35 : 25)
                    .foregroundStyle(isPause ? Color.noticeColor : Color.warningColor)
            }
        })
        .buttonStyle(.plain)
        
    }
}

#Preview {
    IntervalActiveIPhoneScreen(viewModel: .init(interval: .init(id: .init())))
}
