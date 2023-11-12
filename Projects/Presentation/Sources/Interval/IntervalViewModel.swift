//
//  IntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI
import Domain

@MainActor
class IntervalViewModel: ObservableObject {
    private let router: IntervalRouter
    private let intervalUseCase: IntervalUseCaseInterface
    
    @Published var isBottomSheetPresent = false
    
    init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface
    ) {
        self.router = router
        self.intervalUseCase = intervalUseCase
    }
    
    func triggerTransition(route: IntervalRouter.PushRoute) {
        router.triggerScreenTransition(route: route)
    }
    
    func nextScreen() -> some View {
        router.nextTransitionScreen()
    }
}
