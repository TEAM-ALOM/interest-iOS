//
//  WatchIntervalRestingScreen.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI

import WatchDomain
import WatchShared
import WatchSharedDesignSystem

public struct WatchIntervalRestingScreen: View {
    @StateObject var viewModel: WatchIntervalActiveViewModel
    
    public init(viewModel: WatchIntervalActiveViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
        VStack{
            HStack{
                Image(systemName: "circle.hexagonpath.fill")
                    .foregroundColor(Color.burningColor)
                Text("휴식중")
                    .foregroundColor(Color.burningColor)
                Spacer()
            }
            .padding(.horizontal,12)
            
            WatchIntervalInfoActiveView()
        }
        .background{
            LinearGradient(
                stops: [
                    Gradient.Stop(color: Color(red: 0.09, green: 1, blue: 0.02).opacity(0.2), location: 0.00),
                    Gradient.Stop(color: Color(red: 0.09, green: 1, blue: 0.02).opacity(0), location: 1.00),
                ],
                startPoint: UnitPoint(x: 0.5, y: 0),
                endPoint: UnitPoint(x: 0.5, y: 1)
            )
            .ignoresSafeArea()
        }
    }
}
