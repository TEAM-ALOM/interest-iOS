//
//  IntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Domain

public class IntervalViewModel: ObservableObject {
    private let router: IntervalRouter
    private let intervalUseCase: IntervalUseCaseInterface
    
    @Published public var isBottomSheetPresent = false
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        self.intervalUseCase = intervalUseCase
    }
    
    func tapIntervalStartButton(item: IntervalItem) {
        router.triggerScreenTransition(route: .intervalActive)
    }
    
    func triggerTransition(route: IntervalRouter.PushRoute) {
        router.triggerScreenTransition(route: route)
    }
    
    public func nextScreen() -> some View {
        router.nextTransitionScreen()
    }
}
