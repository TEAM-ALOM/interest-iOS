//
//  IntervalActiveViewModel.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

import Domain

@Observable
public class IntervalActiveViewModelWithRouter: IntervalActiveViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface,
        intervalRecordUseCase : IntervalRecordUseCaseInterface,
        intervalItem : IntervalModel
    ) {
        self.router = router
        super.init(
            intervalUseCase: intervalUseCase,
            intervalItem: intervalItem,
            intervalRecordUseCase: intervalRecordUseCase
        )
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


@Observable
public class IntervalActiveViewModel: ObservableObject {
    private let intervalUseCase: IntervalUseCaseInterface
    private let intervalRecordUseCase : IntervalRecordUseCaseInterface
    
    var intervalItem: IntervalModel
    
    var timer: Timer?
    var isBounce : Bool = true

    var currentCount : Int = 0
    var heartRate : Int = 157
    var calorie : Int = 423
    
    var isBurning : Bool = true
    var isTimePass : Bool = true
    var activeTime: TimeInterval = 0
    var totalTime : Double = 0.0
    
    var untilResting : TimeInterval = 0
    var untilBurning : TimeInterval = 0
    
    init(
        intervalUseCase: IntervalUseCaseInterface,
        intervalItem : IntervalModel,
        intervalRecordUseCase : IntervalRecordUseCaseInterface
    ) {
        self.intervalUseCase = intervalUseCase
        self.intervalItem = intervalItem
        self.intervalRecordUseCase = intervalRecordUseCase
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
        saveRecord(intervalRecordItem: intervalItem)
    }
    
    func saveRecord(intervalRecordItem : IntervalModel){
        let newIntervalrecord = IntervalRecordEntity(
            id: intervalRecordItem.id,
            heartRates: [136.0, 130.0], //HealthKit의 평균심박수
            repeatedCount: currentCount,
            secondTime: Int(activeTime),
            createDate: .now,
            calorie: calorie)
        
        intervalRecordUseCase.appendIntervalRecord(intervalId: newIntervalrecord.id, record: newIntervalrecord)
    }
    
    
    func calculateUntilTime() -> String {
        var time = 0.0
        
        if(isBurning){
            untilResting = totalTime - activeTime
            time = untilResting
        }
        else{
            untilBurning = totalTime - activeTime
            time = untilBurning
        }
        
        let minutes = time / 60
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((time * 100).truncatingRemainder(dividingBy: 100))
        
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
        
    }
    
    func calculateActiveTime() -> String {
        let hours = Int(activeTime / 3600)
        let minutes = Int(activeTime / 60)
        let seconds = Int(activeTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int((activeTime * 100).truncatingRemainder(dividingBy: 100))
        
        return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, milliseconds)
    }
}
