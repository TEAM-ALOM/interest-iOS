//
//  IntervalActiveViewModel.swift
//  WatchPresentation
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import SwiftUI

import Dependencies

import Domain
import Combine

@Observable
public class IntervalActiveViewModelWithRouter: IntervalActiveViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        interval: IntervalEntity
    ) {
        self.router = router
        super.init(interval: interval)
    }
    
    override func removeScreen() {
        super.removeScreen()
        router.removeScreenTransition()
    }
    
    override func tapEndButton(){
        super.tapEndButton()
    }
}


@Observable
public class IntervalActiveViewModel: ObservableObject {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    @ObservationIgnored @Dependency(\.intervalRecordUseCase) var intervalRecordUseCase
    @ObservationIgnored @Dependency(\.workoutUseCase) var workoutUseCase
    
    public enum DelegateAction {
        case saved(IntervalRecordEntity)
    }
    
    public var delegateActionHandler: ((DelegateAction) -> ())?
    
    var interval: IntervalEntity
    
    var timer: Timer?
    var isBounce : Bool = true
    
    var currentCount : Int = 1
    var heartRates: [Double] = []
    var calorie: Int = 0
    
    var isBurning : Bool = false
    var isTimePass : Bool = true
    var activeTime: TimeInterval = 0
    var totalTime : TimeInterval
    var startDate: Date?
    
    var untilResting : TimeInterval = 0
    var untilBurning : TimeInterval = 0
    
    private var timerSubscription: AnyCancellable?
    private let timerPublisher = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    init(interval: IntervalEntity) {
        self.interval = interval
        self.totalTime = Double(interval.burningSecondTime)
    }
    
    public func sendSignal(action: DelegateAction) {
        self.delegateActionHandler?(action)
    }
    
    func removeScreen() {}
    
    func tapPauseButton() {
        isTimePass.toggle()
        workoutUseCase.pauseWorkout()
    }
    
    func tapReStartButton() {
        workoutUseCase.resumeWorkout()
        isTimePass = true
    }
    
    func tapEndButton() {
        workoutUseCase.endWorkout()
        
        isTimePass = false
        let newIntervalrecord = IntervalRecordEntity(
            id: .init(),
            heartRates: self.heartRates, // HealthKit의 평균심박수
            repeatedCount: currentCount,
            secondTime: Int(activeTime),
            createDate: .now,
            calorie: calorie)
        
        intervalRecordUseCase.appendIntervalRecord(intervalId: interval.id, record: newIntervalrecord)
        sendSignal(action: .saved(newIntervalrecord))
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
        
        var tmp = (time * 100).truncatingRemainder(dividingBy: 100)
        tmp = (tmp * 10).rounded() / 10
        
        let minutes = Int(time / 60)
        let seconds = Int(time.truncatingRemainder(dividingBy: 60))
        let milliseconds = Int(tmp)
        
        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    func subcribeHeartRate() {
        workoutUseCase.subcribeHeartRate { [weak self] heartRate in
            guard let `self` = self else { return }
            self.heartRates.append(heartRate)
        }
    }
    
    func subscibeCalorie() {
        workoutUseCase.subcribeCalorie { [weak self] calorie in
            guard let `self` = self else { return }
            self.calorie = Int(calorie)
        }
    }
    
    func subscribeWorkoutState() {
        workoutUseCase.observeWorkoutState { [weak self] state in
            guard let `self` = self else { return }
            if state == .ended {
                self.removeScreen()
            }
        }
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
#if os(watchOS)
        guard let startDate = workoutUseCase.workoutStartDate() else {
            return
        }
        workoutUseCase.sendActiveInfoData(.init(currentCount: currentCount,
                                                isBurning: isBurning,
                                                startDate: startDate))
#endif
        timerSubscription = timerPublisher
            .sink { [weak self] _ in
                guard let `self` = self else { return }
#if os(iOS)
                guard let startDate else {
                    return
                }
#endif
                if self.isTimePass {
                    self.activeTime = DateInterval(start: startDate, end: .now).duration
                    self.activeTime = (self.activeTime * 100).rounded() / 100
                    self.totalTime = (self.totalTime * 100).rounded() / 100
                    self.isBounce.toggle()
                    
#if os(watchOS)
                    if(self.activeTime == self.totalTime) {
                        if(!self.isBurning){
                            self.currentCount += 1
                        }
                        
                        self.isBurning.toggle()
                        
                        self.totalTime += Double(self.isBurning ? self.interval.burningSecondTime : self.interval.restingSecondTime)
                        
                        workoutUseCase.sendActiveInfoData(.init(currentCount: currentCount,
                                                                isBurning: isBurning,
                                                                startDate: startDate))
                    }
#endif
                    
                    if(self.currentCount == self.interval.repeatCount + 1){
                        self.currentCount = self.currentCount - 1
                        self.tapEndButton()
                    }
                } else {
                    self.timer?.invalidate()
                    self.timer = nil
                }
            }
    }
}
