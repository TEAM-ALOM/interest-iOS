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
//                if let interval = interval {
                // 임시로 샘플 인터벌을 생성하여 테스트를 진행하였음
                    viewModel.tapStartButton(interval: .init(id: .init()))
//                }
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
