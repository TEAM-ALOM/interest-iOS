//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

class IntervalListViewModel: ObservableObject {
    weak var router: IntervalRouter?
    
    @Published var isBottomSheetPresent = false
    
    init() { }
    
    func triggerTransition(route: IntervalRouter.PushRoute) {
        router?.triggerScreenTransition(route: route)
    }
    
    func nextScreen() -> some View {
        router?.nextTransitionScreen()
    }
}
