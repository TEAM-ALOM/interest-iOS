//
//  IntervalListScreen+WatchOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation

import SwiftUI

public extension IntervalListScreen {
    var watchOS: some View {
        IntervalListWatchScreen(viewModel: viewModel)
    }
}
