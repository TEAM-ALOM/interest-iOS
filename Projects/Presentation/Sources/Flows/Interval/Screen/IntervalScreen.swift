//
//  IntervalScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Domain

public struct IntervalScreen: View {
    @StateObject var router: IntervalRouter
    @StateObject var viewModel: IntervalViewModel
    
    let intervalDIContainer: IntervalDIContainerInterface
    let intervalListScreen: IntervalListScreen
    
    public init(
        intervalDIContainer: IntervalDIContainerInterface
    ) {
        self.intervalDIContainer = intervalDIContainer
        let router = intervalDIContainer.intervalRouter()
        
        self._router = .init(wrappedValue: router)
        self._viewModel = .init(wrappedValue: intervalDIContainer.intervalScreenDependencies(intervalRouter: router))
        
        self.intervalListScreen = .init(viewModel: intervalDIContainer.intervalListDependencies(intervalRouter: router))
    }

    public var body: some View {
#if os(iOS)
        iOS
#elseif os(watchOS)
        watchOS
#endif
    }
}
