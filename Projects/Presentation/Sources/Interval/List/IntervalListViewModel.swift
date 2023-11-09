//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

class IntervalListViewModel: ObservableObject {
    private var router: IntervalRouter
    
    init(router: IntervalRouter) {
        self.router = router
    }
}
