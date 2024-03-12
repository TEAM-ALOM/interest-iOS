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
    @Environment(\.scenePhase) var scenePhase
    
    @Binding var viewModel: IntervalActiveViewModel
    
    var body : some View {
        Group {
            repeatCount
            
            heartBpm
            
            calorie
            
            currentTime
            
            currentSection
        }
    }
    
    private var repeatCount: some View {
        HStack{
            Text("인터벌")
                .foregroundColor(Color.textColor50)
                .font(.system(size: 16))
            
            Spacer()
            
            Text(String(format: "%d / %d",viewModel.currentCount , viewModel.activeInterval.repeatCount))
                .fontWeight(.semibold)
                .foregroundColor(.textColor)
                .font(.system(size: 16, design: .rounded))
                .contentTransition(.numericText())
        }
    }
    
    private var heartBpm: some View {
        HStack{
            Text("심박수")
                .foregroundColor(Color.textColor50)
                .font(.system(size: 16))
            
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(height: 12)
                .foregroundColor(Color.heartColor)
                .symbolEffect(.bounce, options: .speed(1), value: viewModel.totalSecondTime)
            
            Text("\(Int(viewModel.heartRates.last ?? 0.0))")
                .font(.system(size: 20, design: .rounded))
                .fontWeight(.semibold)
                .foregroundColor(.textColor)
                .contentTransition(.numericText())
        }
    }
    
    private var calorie: some View {
        HStack{
            Text("칼로리")
                .foregroundColor(Color.textColor50)
                .font(.system(size: 16))
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
                .font(.system(size: 16))
            
            Spacer()
            
            let isActive = scenePhase == .active
            
            TimelineView(.periodic(from: .now, by: isActive ? 0.01 : 1)) { context in
                Text(isActive ? viewModel.totalTimeString : viewModel.totalTimeStringAOD)
                    .foregroundColor(.textColor)
                    .fontWeight(.semibold)
                    .font(.system(size: 20, design: .rounded))
                    .frame(width: isActive ? 110 : .infinity, alignment: .leading)
                    .allowsTightening(true)
            }
        }
    }
    
    private var currentSection: some View {
        HStack {
            Text("현재구간")
                .foregroundColor(Color.textColor50)
                .font(.system(size: 16))
            
            Spacer()
            
            Text("\(viewModel.currentSection) / \(viewModel.activeInterval.currentIntervalType == .burning ? viewModel.activeInterval.burningHeartIntervalType.heartTypeValue : viewModel.activeInterval.restingHeartIntervalType.heartTypeValue)")
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
