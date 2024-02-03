//
//  IntervalDetailViewModel.swift
//  Presentation
//
//  Created by 김도형 on 11/4/23.
//

import SwiftUI

import Domain

@Observable
public final class IntervalDetailViewModelWithRouter: IntervalDetailViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter
    ) {
        self.router = router
        super.init()
    }
    
    override func tapIntervalStartButton(intervalItem: IntervalModel) {
        super.tapIntervalStartButton(intervalItem: intervalItem)
        router.removeScreenTransition()
    }
}

@Observable
public class IntervalDetailViewModel {
    var intervalItem: IntervalModel
    
    init() {
        self.intervalItem = .init()
    }
    
    func tapIntervalStartButton(intervalItem: IntervalModel) {
        
    }
}
