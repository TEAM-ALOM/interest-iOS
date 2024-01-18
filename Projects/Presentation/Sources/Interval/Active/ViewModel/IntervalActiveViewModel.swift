//
//  IntervalActiveViewModel.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

import Domain

public class IntervalActiveViewModelWithRouter: IntervalActiveViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface,
        intervalItem : IntervalModel
    ) {
        self.router = router
        super.init(
            intervalUseCase: intervalUseCase,
            intervalItem: intervalItem)
    }
}


public class IntervalActiveViewModel: ObservableObject {
    private let intervalUseCase: IntervalUseCaseInterface
    
    @Published var intervalItem: IntervalModel
    
    @Published var heartRate : Int = 157
    @Published var calorie : Int = 423
    @Published var currentCount : Int = 0
    @Published var activeTime: TimeInterval = 0
    @Published var isBurning : Bool = true
    
    init(
        intervalUseCase: IntervalUseCaseInterface,
        intervalItem : IntervalModel
    ) {
        self.intervalUseCase = intervalUseCase
        self.intervalItem = intervalItem
    }
    
    
    func tapPauseButton() {
        
    }
    
    func tapEndButton() {
        
    }
}
