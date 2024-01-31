//
//  HealthInfoView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI

struct HealthInfoView: View {
    @Binding var viewModel: IntervalActiveViewModel
    
    var body: some View {
        VStack(){
            repeatCount
            Spacer()
            calorie
            Spacer()
            heartBpm
            Spacer()
            currentSection
        }
    }
    
    private var repeatCount: some View {
        HStack{
            Text(String(format: "%d / %d",viewModel.currentCount , viewModel.intervalItem.repeatCount))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 36, design: .rounded))
                .padding(.trailing,7)
            
            VStack{
                Spacer()
                Text("진행중")
                    .foregroundColor(Color.textColor50)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
            }
            .frame(height: 36)
            Spacer()
        }
    }
    
    private var calorie: some View {
        HStack{
            Text(String(format: "%d", viewModel.calorie))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 36, design: .rounded))
                .padding(.trailing,7)
            
            VStack{
                Spacer()
                Text("Kcal")
                    .foregroundColor(Color.textColor50)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
            }
            .frame(height: 36)
            Spacer()
        }
    }
    
    private var heartBpm: some View {
        HStack{
            Image(systemName: "heart.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 24,height: 24)
                .foregroundColor(Color.heartColor)
                .symbolEffect(.bounce, options: .speed(1), value: viewModel.isBounce)
                .padding(.trailing,8)
            
            Text(String(viewModel.heartRate))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 36, design: .rounded))
                .padding(.trailing,7)
            
            VStack{
                Spacer()
                Text("bpm")
                    .foregroundColor(Color.textColor50)
                    .fontWeight(.medium)
                    .font(.system(size: 20))
            }
            .frame(height: 36)
            Spacer()
        }
    }
    
    private var currentSection: some View {
        HStack{
            //HealthKit에서 가져와야함
            Text("5")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .font(.system(size: 36, design: .rounded))
                .padding(.trailing,7)
            
            VStack{
                Spacer()
                HStack(spacing : 0) {
                    Text("현재 구간 (목표 : ")
                    Text(viewModel.isBurning ? viewModel.intervalItem.burningHeartIntervalType.rawValue.prefix(1) : viewModel.intervalItem.restingHeartIntervalType.rawValue.prefix(1))
                    Text(")")
                }
                .foregroundColor(Color.textColor50)
                .fontWeight(.medium)
                .font(.system(size: 20))
            }
            .frame(height: 36)
            Spacer()
        }
    }
    
}
