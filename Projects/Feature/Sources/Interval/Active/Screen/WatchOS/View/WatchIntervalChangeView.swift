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
        Group {
            let isBurning = viewModel.activeInterval.currentIntervalType == .burning
            HStack{
                Image(systemName: viewModel.activeInterval.currentIntervalType.systemImage)
                
                Text(viewModel.activeInterval.currentIntervalType.text + "중")
                    .fontWeight(.semibold)
                    .font(.system(size: 20))
                Spacer()
            }
            .foregroundColor(isBurning ? Color.burningColor : Color.restColor)
            
            HStack{
                Text(viewModel.currentSecondTimeString)
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 28, design: .rounded))
                    .frame(width: 112, height: 28, alignment: .leading)
                
                VStack(alignment : .leading){
                    HStack(spacing:0){
                        Text(viewModel.activeInterval.currentIntervalType.text)
                            .offset(y : isBurning ? 0 : 1)
                            .foregroundStyle(isBurning ? Color.restColor : Color.burningColor)
                        Text("까지")
                            .foregroundStyle(Color.textColor50)
                    }
                    
                    Text("남음")
                        .foregroundStyle(Color.textColor50)
                }
                .font(.system(size: 12))
                
                Spacer()
            }
        }
    }
}

#Preview {
    IntervalActiveWatchScreen(viewModel: .init(interval: .init(id: .init())))
}
