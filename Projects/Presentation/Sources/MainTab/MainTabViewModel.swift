//
//  MainTabViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

class MainTabViewModel: ObservableObject {
    @Published
    var isBottomSheetPresent = false
    
    private var router: MainTabRouter
    
    init(router: MainTabRouter) {
        self.router = router
    }
}
