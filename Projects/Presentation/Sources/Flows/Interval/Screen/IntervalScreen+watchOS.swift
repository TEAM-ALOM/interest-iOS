//
//  IntervalScreen+watchOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import SwiftUI

public extension IntervalScreen {
    var watchOS: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack {
                intervalListScreen
                
                Button(action: {
                    // TODO: 실제 인터벌을 고르고 startButton을 누르는것으로 변경해야함
//                    viewModel.tapIntervalStartButton(item: .init(title: "테스트 인터벌"))
                }) {
                    //FIXME: 버튼이 이상함..
                    Image(systemName: "play.circle.fill")
                        .foregroundStyle(Color.keyColor)
                }
            }
            .navigationTitle("인터레스트")
            .navigationDestination(for: IntervalRouter.NavigationRoute.self) { _ in
                viewModel.nextScreen()
            }
        }
    }
}
