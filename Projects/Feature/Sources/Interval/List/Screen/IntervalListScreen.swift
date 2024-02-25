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
    @State var listViewModel: IntervalListViewModel

    public init(
        listViewModel: IntervalListViewModel
    ) {
        self._listViewModel = .init(wrappedValue: listViewModel)
    }
    
    public var body: some View {
#if os(iOS)
        iOS
#elseif os(watchOS)
        watchOS
#endif
    }
}

#Preview {
    IntervalListScreen(listViewModel: .init())
}
