//
//  HealthInfoView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import Foundation
import SwiftUI

struct HealthInfoView : View{
    @ObservedObject var viewModel: IntervalActiveViewModel

    @Binding var isBounce : Bool
    @Binding var totalTime : Double

    var body : some View {
        VStack(spacing : 5){
            HStack{
                Text("인터벌")
                    .foregroundColor(Color.textColor50)
                
                Spacer()
                
                Text(String(format: "%d / %d",viewModel.currentCount , viewModel.intervalItem.repeatCount))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.system(size: 16, design: .rounded))
                
            }
            HStack{
                Text("심박수")
                    .foregroundColor(Color.textColor50)
                
                Spacer()
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16,height: 16)
                    .foregroundColor(Color.heartColor)
                    .symbolEffect(.bounce, options: .speed(1), value: isBounce)
                
                Text(String(viewModel.heartRate))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.system(size: 16, design: .rounded))
            }
            HStack{
                Text("칼로리")
                    .foregroundColor(Color.textColor50)
                
                Spacer()
                
                Text(String(format: "%dKcal", viewModel.calorie))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .font(.system(size: 16, design: .rounded))
            }
            HStack{
                Text("진행시간")
                    .foregroundColor(Color.textColor50)
                
                Spacer()
                
                Text(IntervalTimer(viewModel: viewModel, totalTime: $totalTime).formattedBurningTime)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 16, design: .rounded))
            }
        }
        .padding(.horizontal,12)
    }
}
