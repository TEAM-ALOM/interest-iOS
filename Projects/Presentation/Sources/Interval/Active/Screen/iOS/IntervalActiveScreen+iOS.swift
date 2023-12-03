//
//  IntervalActiveScreen+iOS.swift
//  Presentation
//
//  Created by 송영모 on 12/3/23.
//

import Foundation
import SwiftUI

public extension IntervalActiveScreen {
    var iOS: some View {
        IntervalActiveIPhoneScreen(viewModel: viewModel)
    }
}
