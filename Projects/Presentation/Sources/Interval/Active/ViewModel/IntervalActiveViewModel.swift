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
    
    override func removeScreen() {
        super.removeScreen()
        router.removeScreenTransition()
    }
    
    override func tapEndButton(){
        super.tapEndButton()
        router.removeScreenTransition()
    }
}


public class IntervalActiveViewModel: ObservableObject {
    private let intervalUseCase: IntervalUseCaseInterface
    
    @Published var intervalItem: IntervalModel

    @Published var currentCount : Int = 0
    @Published var heartRate : Int = 157
    @Published var calorie : Int = 423
    
    @Published var isBurning : Bool = true
    @Published var isTimePass : Bool = true
    @Published var activeTime: TimeInterval = 0
    @Published var totalTime : Double = 0.0

    
    init(
        intervalUseCase: IntervalUseCaseInterface,
        intervalItem : IntervalModel
    ) {
        self.intervalUseCase = intervalUseCase
        self.intervalItem = intervalItem
    }
    
    func removeScreen() {}
    
    func tapPauseButton() {
        isTimePass.toggle()
    }
    
    func tapReStartButton() {
        isTimePass = true
    }
    
    func tapEndButton() {
        isTimePass = false
        //기록 저장
    }
}
