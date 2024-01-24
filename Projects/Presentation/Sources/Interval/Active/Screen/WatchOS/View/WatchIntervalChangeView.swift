//
//  IntervalChanged.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import Foundation
import SwiftUI

struct WatchIntervalChangeView : View {
    @Binding var viewModel: IntervalActiveViewModel
    
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
            .padding(.bottom, 5)
            Spacer()
            HStack{
                Spacer()
                HStack{
                    Text(viewModel.calculateUntilTime())
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 28, design: .rounded))
                        .frame(width: 112, height: 28, alignment: .leading)
                }
                VStack(alignment : .leading){
                    HStack(spacing:0){
                        Text(viewModel.isBurning ? "휴식" : "버닝")
                            .offset(y : viewModel.isBurning ? 0 : 1)
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
                Spacer()
            }
            .frame(width: 161, height: 28)
        }
    }
}
