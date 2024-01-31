//
//  IntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Domain

@Observable public final class IntervalViewModel {
    private let router: IntervalRouter
    private let intervalUseCase: IntervalUseCaseInterface
    
    public var isBottomSheetPresent = false
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        self.intervalUseCase = intervalUseCase
    }

    public func tapPlusButton() {
        router.triggerPresentationScreen(presentationRoute: .addInterval)
    }

    public func tapIntervalStartButton(intervalItem: IntervalModel) {
        router.triggerNavigationScreen(navigationRoute: .intervalActive(intervalItem))
    }

    public func nextScreen() -> some View {
        router.nextNavigationScreen()
    }
}
