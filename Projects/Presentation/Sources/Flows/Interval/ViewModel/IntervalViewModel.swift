//
//  IntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

import Dependencies

import Domain

@Observable 
public final class IntervalViewModel {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    
    private let router: IntervalRouter
    
    public var isBottomSheetPresent = false
    
    public init(
        router: IntervalRouter
    ) {
        self.router = router
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
