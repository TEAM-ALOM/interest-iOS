//
//  WatchIntervalViewModel.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI
import WatchDomain

public class WatchIntervalViewModel: ObservableObject {
    private let router: WatchIntervalRouter
    private let intervalUseCase: WatchIntervalUseCaseInterface
    
    @Published public var isBottomSheetPresent = false
    
    public init(
        router: WatchIntervalRouter,
        intervalUseCase: WatchIntervalUseCaseInterface
    ) {
        self.router = router
        self.intervalUseCase = intervalUseCase
    }
    
    func triggerTransition(route: WatchIntervalRouter.PushRoute) {
        router.triggerScreenTransition(route: route)
    }
    
    public func nextScreen() -> some View {
        router.nextTransitionScreen()
    }
}
