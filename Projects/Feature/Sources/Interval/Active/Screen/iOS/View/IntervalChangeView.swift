//
//  IntervalChangeView.swift
//  Presentation
//
//  Created by 최유경 on 1/19/24.
//

import SwiftUI
import SharedDesignSystem

struct IntervalChangeView: View {
    @Binding var viewModel: IntervalActiveViewModel
    
    var body: some View {
        Group {
            let isBurning = viewModel.activeInterval.currentIntervalType == .burning
            
            HStack{
                Image(systemName: viewModel.activeInterval.currentIntervalType.systemImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30,height: 30)
                
                Text(viewModel.activeInterval.currentIntervalType.text + "중")
                    .fontWeight(.bold)
                    .font(.system(size: 34))
                
                Spacer()
            }
            .foregroundStyle(isBurning ? Color.burningColor : Color.restColor)
            
            HStack{
                HStack{
                    Text(viewModel.currentTimeString)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 52, design: .rounded))
                        .frame(width: 235, height: 52 , alignment: .leading)
                }
                
                VStack(alignment : .leading){
                    HStack(spacing:0){
                        Text(viewModel.activeInterval.currentIntervalType.text)
                            .offset(y : isBurning ? 0 : 1)
                            .foregroundStyle(isBurning ? Color.restColor : Color.burningColor)
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
                
                Spacer()
            }
        }
    }
}

#Preview {
    IntervalActiveIPhoneScreen(viewModel: .init(interval: .init(id: .init())))
}
