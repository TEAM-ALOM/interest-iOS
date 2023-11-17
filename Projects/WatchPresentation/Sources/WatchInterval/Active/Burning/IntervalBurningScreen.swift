//
//  WatchIntervalBurningScreen.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import WatchDomain
import WatchShared
import SwiftUI

public struct IntervalBurningScreen: View {
    @StateObject var viewModel: IntervalActiveViewModel
    
    public init(viewModel: IntervalActiveViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack{
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
                
                VStack{
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
                .multilineTextAlignment(.leading)
            }
            Spacer()
            IntervalInfoActiveView()
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
