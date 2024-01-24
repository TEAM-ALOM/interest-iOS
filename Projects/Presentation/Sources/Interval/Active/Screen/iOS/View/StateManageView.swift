//
//  StateManageView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI
import SharedDesignSystem

struct StateManageView: View {
    @Binding var viewModel: IntervalActiveViewModel
    
    var body: some View {
        VStack{
            Text(viewModel.calculateActiveTime())
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 52, design: .rounded))
                .frame(width: 330, height: 52)
            
            Spacer(minLength: 150)
            
        }
        .overlay(alignment: .bottom) {
            stateButton(isPause: true, action: viewModel.tapPauseButton)
        }
        .overlay(alignment: .bottomTrailing){
            stateButton(isPause: false, action: viewModel.tapEndButton)
            
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



