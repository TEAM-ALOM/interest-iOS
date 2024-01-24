//
//  HealthInfoView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import Foundation
import SwiftUI

struct WatchHealthInfoView : View{
    @Binding var viewModel: IntervalActiveViewModel
        
    var body : some View {
        VStack(alignment: .leading, spacing : 5){
            repeatCount
            heartBpm
            calorie
            currentTime
        }
        .padding(.horizontal,12)
    }
    
    private var repeatCount: some View {
        HStack{
            Text("인터벌")
                .foregroundColor(Color.textColor50)
            
            Spacer()
            
            Text(String(format: "%d / %d",viewModel.currentCount , viewModel.intervalItem.repeatCount))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 16, design: .rounded))
        }
    }
    
    private var heartBpm: some View {
        HStack{
            Text("심박수")
                .foregroundColor(Color.textColor50)
            Spacer()
            
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 16,height: 16)
                .foregroundColor(Color.heartColor)
                .symbolEffect(.bounce, options: .speed(1), value: viewModel.isBounce)
            
            Text(String(viewModel.heartRate))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 16, design: .rounded))
        }
    }
    
    private var calorie: some View {
        HStack{
            Text("칼로리")
                .foregroundColor(Color.textColor50)
            Spacer()
            
            Text(String(format: "%dKcal", viewModel.calorie))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 16, design: .rounded))
        }
    }
    
    private var currentTime: some View {
        HStack{
            Text("진행 시간")
                .foregroundColor(Color.textColor50)
            Spacer()
            
            Text(viewModel.calculateActiveTime())
                .foregroundColor(.white)
                .fontWeight(.semibold)
                .font(.system(size: 16, design: .rounded))
        }
    }
}
