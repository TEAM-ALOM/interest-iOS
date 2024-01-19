//
//  IntervalChangeView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI

struct IntervalChangeView: View {
    @ObservedObject var viewModel: IntervalActiveViewModel
    
    @Binding var totalTime : Double
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: viewModel.isBurning ? "flame.fill" : "circle.hexagonpath.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(viewModel.isBurning ? Color.burningColor : Color.restColor)
                    .frame(width: 30,height: 30)
                
                Text(viewModel.isBurning ? "버닝중" : "휴식중")
                    .foregroundColor(viewModel.isBurning ? Color.burningColor : Color.restColor)
                    .fontWeight(.bold)
                    .font(.system(size: 34))
                    
                Spacer()
            }
            
            HStack{
                HStack{
                    Text(IntervalTimer(viewModel: viewModel, totalTime: $totalTime).calculateUntilTime)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 52, design: .rounded))
                }
                                
                VStack(alignment : .leading){
                    HStack(spacing:0){
                        Text(viewModel.isBurning ? "휴식" : "버닝")
                            .foregroundStyle(viewModel.isBurning ? Color.restColor : Color.burningColor)
                        Text("까지")
                            .foregroundStyle(Color.textColor50)
                    }
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    
                    HStack{
                        Text("남음")
                            .foregroundStyle(Color.textColor50)
                            .font(.system(size: 20))
                            .fontWeight(.semibold)
                    }
                }
                .padding(.leading,16)
                
                Spacer()
            }
            //.frame(width: 300, height: 52)
        }
    }
}

