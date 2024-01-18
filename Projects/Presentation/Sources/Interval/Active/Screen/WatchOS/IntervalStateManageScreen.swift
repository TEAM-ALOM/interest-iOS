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

public struct IntervalStateManageScreen: View {
    @ObservedObject var viewModel: IntervalActiveViewModel
    
    public var body: some View {
        VStack{
            Spacer()
            
            HStack{
                Text("달리기")
                    .foregroundStyle(Color.keyColor)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            
            HStack(spacing: 16){
                stateButton(isPause: true)
                stateButton(isPause: false)
            }
            
            Spacer()
            
        }
        .mainBackground()
    }
    
    
    @ViewBuilder
    func stateButton(isPause : Bool) -> some View {
        VStack{
            Button(action: {
                //일시 정지, 운동 종료 만들어야함
            }) {
                Image(systemName: isPause ? "pause.fill" : "xmark")
                    .resizable()
                    .frame(width: 20, height: 25)
                    .foregroundStyle(isPause ? Color.noticeColor : Color.warningColor)
            }
            .frame(width: 72, height: 52)
            .buttonStyle(.plain)
            .background(isPause ? Color.noticeColor25 : Color.warningColor25)
            .cornerRadius(20)
            
            Text(isPause ? "일시 정지" : "운동 종료")
                .font(.system(size: 12))
                .fontWeight(.medium)
                .foregroundColor(Color.textColor50)
        }
    }
}
