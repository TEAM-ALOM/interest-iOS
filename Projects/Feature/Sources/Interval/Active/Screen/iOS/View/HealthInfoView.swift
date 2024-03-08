//
//  HealthInfoView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI
import SharedDesignSystem

struct HealthInfoView: View {
    @Binding var viewModel: IntervalActiveViewModel
    
    var body: some View {
        Group {
            repeatCount
            calorie
            heartBpm
            currentSection
        }
    }
    
    private var repeatCount: some View {
        HStack(alignment: .bottom) {
            Text(String(format: "%d / %d",viewModel.currentCount , viewModel.interval?.repeatCount ?? 0))
                .fontWeight(.semibold)
                .foregroundColor(.textColor)
                .font(.system(size: 36, design: .rounded))
                .padding(.trailing, 8)
                .contentTransition(.numericText())
            
            Text("진행중")
                .foregroundColor(Color.textColor50)
                .fontWeight(.medium)
                .font(.system(size: 20))
            
            Spacer()
        }
    }
    
    private var calorie: some View {
        HStack(alignment: .bottom) {
            Text("\(Int(viewModel.calorie))")
                .fontWeight(.semibold)
                .foregroundColor(.textColor)
                .font(.system(size: 36, design: .rounded))
                .padding(.trailing, 8)
                .contentTransition(.numericText())
            
            Text("Kcal")
                .foregroundColor(Color.textColor50)
                .fontWeight(.medium)
                .font(.system(size: 20))
            
            Spacer()
        }
    }
    
    private var heartBpm: some View {
        HStack(spacing: 8) {
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24,height: 24)
                .foregroundColor(Color.heartColor)
                .symbolEffect(.bounce, options: .speed(1), value: viewModel.isBounce)
            
            HStack(alignment: .bottom, spacing: 8) {
                Text("\(Int(viewModel.heartRates.last ?? 0.0))")
                    .fontWeight(.semibold)
                    .foregroundColor(.textColor)
                    .font(.system(size: 36, design: .rounded))
                    .contentTransition(.numericText())
                
                
                Text("bpm")
                    .foregroundColor(Color.textColor50)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
            }
            Spacer()
        }
    }
    
    private var currentSection: some View {
        HStack(alignment: .bottom) {
            //HealthKit에서 가져와야함
            Text("\(viewModel.currentSection)")
                .fontWeight(.semibold)
                .foregroundColor(.textColor)
                .font(.system(size: 36, design: .rounded))
                .padding(.trailing, 8)
                .contentTransition(.numericText())
            
            Text("현재 구간 (목표 : \(viewModel.activeInterval.currentIntervalType == .burning ? viewModel.interval?.burningHeartIntervalType.heartTypeValue ?? 0 : viewModel.interval?.restingHeartIntervalType.heartTypeValue ?? 0))")
                .foregroundColor(Color.textColor50)
                .fontWeight(.medium)
                .font(.system(size: 20))
            
            Spacer()
        }
    }
}

#Preview {
    IntervalActiveIPhoneScreen(viewModel: .init(interval: .init(id: .init())))
}
