//
//  IntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

@MainActor
class IntervalViewModel: ObservableObject {
    private var router: IntervalRouter
    
    init(router: IntervalRouter) {
        self.router = router
    }
    
    func triggerTransition(route: IntervalRouter.PushRoute) {
        router.triggerScreenTransition(route: route)
    }
    
    func nextScreen() -> some View {
        router.nextTransitionScreen()
    }
}
