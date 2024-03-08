//
//  HealthInfoView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import Foundation
import SwiftUI
import SharedDesignSystem

struct WatchHealthInfoView : View{
    @Binding var viewModel: IntervalActiveViewModel
    
    var body : some View {
        Group {
            repeatCount
            
            heartBpm
            
            calorie
            
            currentTime
            
        }
    }
    
    private var repeatCount: some View {
        HStack{
            Text("인터벌")
                .foregroundColor(Color.textColor50)
                .fontWeight(.semibold)
                .font(.system(size: 20, design: .rounded))
            
            Spacer()
            
            Text(String(format: "%d / %d",viewModel.currentCount , viewModel.interval?.repeatCount ?? 0))
                .fontWeight(.semibold)
                .foregroundColor(.textColor)
                .font(.system(size: 20, design: .rounded))
                .contentTransition(.numericText())
        }
    }
    
    private var heartBpm: some View {
        HStack{
            Text("심박수")
                .foregroundColor(Color.textColor50)
                .fontWeight(.semibold)
                .font(.system(size: 20, design: .rounded))
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 20)
                .foregroundColor(Color.heartColor)
                .symbolEffect(.bounce, options: .speed(1), value: viewModel.totalSecondTime)
            
            Text("\(Int(viewModel.heartRates.last ?? 0.0))")
                .fontWeight(.semibold)
                .font(.system(size: 20, design: .rounded))
                .foregroundColor(.textColor)
                .contentTransition(.numericText())
        }
    }
    
    private var calorie: some View {
        HStack{
            Text("칼로리")
                .foregroundColor(Color.textColor50)
                .fontWeight(.semibold)
                .font(.system(size: 20, design: .rounded))
            Spacer()
            
            Text("\(Int(viewModel.calorie))")
                .fontWeight(.semibold)
                .foregroundColor(.textColor)
                .font(.system(size: 20, design: .rounded))
                .contentTransition(.numericText())
        }
    }
    
    private var currentTime: some View {
        HStack{
            Text("진행시간")
                .foregroundColor(Color.textColor50)
                .font(.system(size: 20))
            
            Spacer()
            
            Text(viewModel.totalSecondTimeString)
                .foregroundColor(.textColor)
                .fontWeight(.semibold)
                .font(.system(size: 20, design: .rounded))
                .frame(height: 20, alignment: .leading)
        }
    }
}

#Preview {
    IntervalActiveWatchScreen(viewModel: .init(interval: .init(id: .init())))
}
