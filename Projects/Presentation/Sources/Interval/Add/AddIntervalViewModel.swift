//
//  AddIntervalViewModel.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI

class AddIntervalViewModel: ObservableObject {
    private var router: IntervalRouter
    
    init(router: IntervalRouter) {
        self.router = router
    }

}

