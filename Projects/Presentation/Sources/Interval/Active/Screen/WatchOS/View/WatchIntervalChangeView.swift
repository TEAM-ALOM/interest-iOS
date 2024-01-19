//
//  IntervalChanged.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import Foundation
import SwiftUI

struct WatchIntervalChangeView : View {
    @ObservedObject var viewModel: IntervalActiveViewModel
    
    var body: some View {
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
                    Text(IntervalTimer(viewModel: viewModel).calculateUntilTime)
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
}
