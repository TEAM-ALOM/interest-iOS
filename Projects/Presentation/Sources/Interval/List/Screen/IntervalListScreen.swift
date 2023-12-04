//
//  IntervalListScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Domain
import SharedDesignSystem

public struct IntervalListScreen: View {
    @StateObject var viewModel: IntervalListViewModel
    
    public init(viewModel: IntervalListViewModel) {
        self._viewModel = .init(wrappedValue: viewModel)
    }
    
    public var body: some View {
#if os(iOS)
        iOS
#elseif os(watchOS)
        watchOS
#endif
    }
}
