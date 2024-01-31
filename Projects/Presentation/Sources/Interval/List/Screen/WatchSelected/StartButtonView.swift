//
//  WatchDetailView.swift
//  Presentation
//
//  Created by 최유경 on 1/18/24.
//

import Foundation
import SwiftUI

struct StartButton: View {
    var viewModel: IntervalListViewModel
        
    public var intervalItem: IntervalModel

    var body : some View {
            Button(action: {
                viewModel.tapStartButton(intervalItem: intervalItem)
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
