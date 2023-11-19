//
//  WatchIntervalBurningScreen.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI

import WatchDomain
import WatchShared
import WatchSharedDesignSystem


public struct WatchIntervalBurningScreen: View {
    @StateObject var viewModel: WatchIntervalActiveViewModel
    
    public init(viewModel: WatchIntervalActiveViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack(alignment: .center){
            HStack{
                Image(systemName: "flame.fill")
                    .foregroundColor(Color.burningColor)
                Text("버닝중")
                    .foregroundColor(Color.burningColor)
                Spacer()
            }
            .padding(.horizontal,12)
            HStack{
                Text("01:36.20")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 28))
                
                VStack(alignment : .leading){
                    HStack(spacing:0){
                        Text("휴식")
                            .foregroundStyle(Color.restColor)
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
            Spacer()
            WatchIntervalInfoActiveView()
        }
        .background{
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 1, green: 0.13, blue: 0.02).opacity(0.2), location: 0.00),
                    Gradient.Stop(color: Color(red: 1, green: 0.13, blue: 0.02).opacity(0), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea()
        }
    }
}
