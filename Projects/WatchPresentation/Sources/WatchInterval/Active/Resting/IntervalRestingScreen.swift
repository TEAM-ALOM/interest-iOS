//
//  WatchIntervalRestingScreen.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import WatchDomain
import WatchShared
import SwiftUI
import WatchSharedDesignSystem

public struct IntervalRestingScreen: View {
    @StateObject var viewModel: IntervalActiveViewModel
    
    public init(viewModel: IntervalActiveViewModel) {
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
            
            IntervalInfoActiveView()
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
