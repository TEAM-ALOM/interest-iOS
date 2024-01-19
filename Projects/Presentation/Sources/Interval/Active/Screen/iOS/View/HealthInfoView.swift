//
//  HealthInfoView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI

struct HealthInfoView: View {
    @ObservedObject var viewModel: IntervalActiveViewModel

    @Binding var isBounce : Bool
    @Binding var totalTime : Double
    
    var body: some View {
        VStack(alignment: .leading, spacing : 5){
           repeatCount
            calorie
            heartBpm
            currentSection
        }
    }
    
    private var repeatCount: some View {
        HStack{
            Text(String(format: "%d / %d",viewModel.currentCount , viewModel.intervalItem.repeatCount))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 36, design: .rounded))
                .padding(.trailing,8)

            Text("진행중")
                .foregroundColor(Color.textColor50)
                .fontWeight(.medium)
                .font(.system(size: 20))
        }
    }
    
    private var calorie: some View {
        HStack{
            Text(String(format: "%d", viewModel.calorie))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 16, design: .rounded))
                .padding(.trailing,8)

            Text("Kcal")
                .foregroundColor(Color.textColor50)
                .fontWeight(.medium)
                .font(.system(size: 20))
        }
    }
    
    private var heartBpm: some View {
        HStack{
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24,height: 24)
                .foregroundColor(Color.heartColor)
                .symbolEffect(.bounce, options: .speed(1), value: isBounce)
                .padding(.trailing,8)
            
            Text(String(viewModel.heartRate))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 16, design: .rounded))
                .padding(.trailing,8)
            
            Text("bpm")
                .foregroundColor(Color.textColor50)
                .fontWeight(.medium)
                .font(.system(size: 20))
        }
    }
    
    private var currentSection: some View {
        HStack{
            Text("5")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 16, design: .rounded))
                .padding(.trailing,8)
            
            Text(viewModel.isBurning ? viewModel.intervalItem.burningHeartIntervalType.rawValue.prefix(1) : viewModel.intervalItem.restingHeartIntervalType.rawValue.prefix(1))
                .foregroundColor(Color.textColor50)
                .fontWeight(.medium)
                .font(.system(size: 20))
        }
    }
    
}
