//
//  IntervalListWatchScreen.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI
import SharedDesignSystem

public struct IntervalListWatchScreen: View {
    @ObservedObject var viewModel: IntervalListViewModel
    
    public var body: some View {
        WatchSelectedView(viewModel: viewModel)
            .mainBackground()
    }

    
}
