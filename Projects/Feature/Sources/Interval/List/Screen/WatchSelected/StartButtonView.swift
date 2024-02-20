//
//  WatchDetailView.swift
//  Presentation
//
//  Created by 최유경 on 1/18/24.
//

import Foundation
import SwiftUI
import Domain

struct StartButton: View {
    var viewModel: IntervalListViewModel
        
    public var interval: IntervalEntity?

    var body : some View {
            Button(action: {
                if let interval = interval {
                    viewModel.tapStartButton(interval: interval)
                }
            }) {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color.keyColor)
            }
            .frame(width: 52,height: 52)
            .buttonStyle(.plain)
        }
    

}
