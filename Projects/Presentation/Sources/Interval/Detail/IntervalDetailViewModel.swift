//
//  IntervalDetailViewModel.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI

class IntervalDetailViewModel: ObservableObject {
    private var router: IntervalRouter
    
    init(router: IntervalRouter) {
        self.router = router
    }
}
