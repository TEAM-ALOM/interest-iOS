//
//  IntervalActiveViewModel.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation

import Dependencies

import Domain
import Combine

@Observable
public class IntervalActiveViewModelWithRouter: IntervalActiveViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter
    ) {
        self.router = router
        super.init()
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
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    @ObservationIgnored @Dependency(\.intervalRecordUseCase) var intervalRecordUseCase
    
    var intervalItem: IntervalModel
    
    var timer: Timer?
    var isBounce : Bool = true
    
    var currentCount : Int = 1
    var heartRate : Int = 157
    var calorie : Int = 423
    
    var isBurning : Bool = true
    var isTimePass : Bool = true
    var activeTime: TimeInterval = 0
    var totalTime : TimeInterval
    
    var untilResting : TimeInterval = 0
    var untilBurning : TimeInterval = 0
    
    private var timerSubscription: AnyCancellable?
    private let timerPublisher = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    init() { 
        self.intervalItem = .init()
        self.totalTime = 0
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
            heartRates: [136.0, 130.0], // HealthKit의 평균심박수
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
        time = (time * 100).rounded() / 100
        print(time)
        
        var tmp = (time * 100).truncatingRemainder(dividingBy: 100)
        tmp = (tmp * 10).rounded() / 10
        
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int(tmp)
        
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
        
    }
    
    func calculateActiveTime() -> String {
        var tmp = (activeTime * 100).truncatingRemainder(dividingBy: 100)
        tmp = (tmp * 10).rounded() / 10
        
        let hours = Int(activeTime / 3600)
        let minutes = Int(activeTime / 60)
        let seconds = Int(activeTime.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int(tmp)
        
        return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, milliseconds)
    }
    
    func setupTimer() {
        timerSubscription = timerPublisher
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.isTimePass {
                    self.activeTime += 0.01
                    self.activeTime = (self.activeTime * 100).rounded() / 100
                    self.totalTime = (self.totalTime * 100).rounded() / 100
                    isBounce.toggle()
                    
                    if(activeTime == totalTime){
                        if(!isBurning){
                            currentCount += 1
                        }
                        isBurning.toggle()
                        
                        self.totalTime += Double(isBurning ?  intervalItem.burningSecondTime : intervalItem.restingSecondTime)
                        
                        print(totalTime)
                    }
                    
                    if(currentCount == intervalItem.repeatCount + 1){
                        currentCount = currentCount - 1
                        tapEndButton()
                    }
                }
                else {
                    timer?.invalidate()
                    timer = nil
                }
            }
    }
}
