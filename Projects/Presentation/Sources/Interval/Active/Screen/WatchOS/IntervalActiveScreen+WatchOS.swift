//
//  IntervalActiveScreen+WatchOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI

public extension IntervalActiveScreen {
    var watchOS: some View {
        TabView {
            IntervalActiveWatchScreen(viewModel: viewModel)
            
            IntervalStateManageScreen(viewModel: viewModel)
        }
    }
}
