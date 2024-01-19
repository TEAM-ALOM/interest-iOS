//
//  IntervalChangeView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI

struct IntervalChangeView: View {
    @ObservedObject var viewModel: IntervalActiveViewModel
        
    var body: some View {
        VStack{
            HStack{
                Image(systemName: $viewModel.isBurning.wrappedValue ? "flame.fill" : "circle.hexagonpath.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor($viewModel.isBurning.wrappedValue ? Color.burningColor : Color.restColor)
                    .frame(width: 30,height: 30)
                
                Text($viewModel.isBurning.wrappedValue ? "버닝중" : "휴식중")
                    .foregroundColor($viewModel.isBurning.wrappedValue ? Color.burningColor : Color.restColor)
                    .fontWeight(.bold)
                    .font(.system(size: 34))
                    
                Spacer()
            }
            
            HStack{
                HStack{
                    Text(IntervalTimer(viewModel: viewModel).calculateUntilTime)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 52, design: .rounded))
                }
                                
                VStack(alignment : .leading){
                    HStack(spacing:0){
                        Text($viewModel.isBurning.wrappedValue ? "휴식" : "버닝")
                            .foregroundStyle($viewModel.isBurning.wrappedValue ? Color.restColor : Color.burningColor)
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
        }
    }
}

