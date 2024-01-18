//
//  IntervalActiveScreenWithWatchOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct IntervalActiveWatchScreen: View {
    @ObservedObject var viewModel: IntervalActiveViewModel
    
    @State private var isBounce = true
    @State private var timer: Timer?
    
    public var body: some View {
        VStack(alignment: .center){
            intervalChange
            
            Spacer()
            
            healthInfo
        }
        .exerciseBackground(mode: viewModel.isBurning ? .burning : .rest)
      
        .onAppear(perform: {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                viewModel.activeTime += 0.01
                isBounce.toggle()
            }
        })
    }
    
    private var intervalChange: some View {
        VStack{
            HStack{
                Image(systemName: viewModel.isBurning ? "flame.fill" : "circle.hexagonpath.fill")
                    .foregroundColor(viewModel.isBurning ? Color.burningColor : Color.restColor)
                Text(viewModel.isBurning ? "버닝중" : "휴식중")
                    .foregroundColor(viewModel.isBurning ? Color.burningColor : Color.restColor)
                Spacer()
            }
            .padding(.horizontal,12)
            
            HStack{
                HStack{
                    Text("")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 28, design: .rounded))
                }
                
                Spacer()
                
                VStack(alignment : .leading){
                    HStack(spacing:0){
                        Text(viewModel.isBurning ? "휴식" : "버닝")
                            .foregroundStyle(viewModel.isBurning ? Color.restColor : Color.burningColor)
                        Text("까지")
                            .foregroundStyle(Color.textColor50)
                    }
                    .font(.system(size: 10))
                    
                    HStack{
                        Text("남음")
                            .foregroundStyle(Color.textColor50)
                            .font(.system(size: 10))
                        
                    }
                }
            }
            .frame(width: 161, height: 28)
        }
    }
    
    private var healthInfo : some View {
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
                
                Text(formattedBurningTime)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 16, design: .rounded))
            }
        }
        .padding(.horizontal,12)
    }
    
    private var formattedBurningTime: String {
        let hours = Int(viewModel.activeTime / 3600)
        let minutes = Int(viewModel.activeTime / 60)
        let seconds = Int(viewModel.activeTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((viewModel.activeTime * 100).truncatingRemainder(dividingBy: 100))
        
        return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, milliseconds)
    }

}
