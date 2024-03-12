//
//  WatchIntervalStateManageScreen.swift
//  WatchPresentation
//
//  Created by 민지은 on 2023/11/28.
//

import Foundation
import SwiftUI

import Domain
import Shared
import SharedDesignSystem

public struct WatchStateManageView: View {
    var viewModel: IntervalActiveViewModel
    
    public var body: some View {
        VStack{
            Spacer()
            intervalName
            HStack {
                Spacer()
                watchStateButton(isPause: true, action: viewModel.tapPauseButton)
                Spacer()
                watchStateButton(isPause: false, action: viewModel.tapEndButton)
                Spacer()
            }
            Spacer()
        }
        .mainBackground()
    }
    
    private var intervalName: some View {
        HStack{
            Text(viewModel.activeInterval.intervalTitle)
                .foregroundStyle(Color.keyColor)
            Spacer()
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
    
    @ViewBuilder
    func watchStateButton(isPause : Bool, action: @escaping () -> Void) -> some View {
        let isRunning = viewModel.workoutSessionState == .running
        
        VStack{
            Button(action: action) {
                Image(systemName: isPause ? isRunning ? "pause.fill" : "play.fill" : "xmark")
                    .resizable()
                    .frame(width: 20, height: 25)
                    .foregroundStyle(isPause ? Color.noticeColor : Color.warningColor)
            }
            .frame(width: 72, height: 52)
            .buttonStyle(.plain)
            .background(isPause ? Color.noticeColor25 : Color.warningColor25)
            .cornerRadius(20)
            
            Text(isPause ? isRunning ? "일시 정지" : "재개" : "운동 종료")
                .font(.system(size: 12))
                .fontWeight(.medium)
                .foregroundColor(Color.textColor50)
        }
    }
}

#Preview {
    WatchStateManageView(viewModel: .init())
}
