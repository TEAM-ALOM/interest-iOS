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
    @ObservationIgnored @Dependency(\.wcSessionUseCase) var wcSessionUseCase
    
    public enum DelegateAction {
        case saved(IntervalRecordEntity)
    }
    
    public var delegateActionHandler: ((DelegateAction) -> ())?
    
    @ObservationIgnored var interval: IntervalEntity
    var activeInterval: ActiveIntervalEntity
    
    var timer: Timer?
    var isBounce : Bool = true
    
    @ObservationIgnored var totalSecondTime: TimeInterval = 0
    @ObservationIgnored var currentSecondTime: TimeInterval = 0
    @ObservationIgnored var currentCount : Int = 1
    var workoutSessionState: WorkoutSessionState = .running
    var heartRates: [Double] = []
    var calorie : Int = 0
    
    var currentSecondTimeString = "00:00:00.00"
    var totalSecondTimeString = "00:00:00.00"
    
    @ObservationIgnored let startDate: Date = .now
    
    @ObservationIgnored private var timerSubscription: AnyCancellable?
    @ObservationIgnored private let timerPublisher = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    init(interval: IntervalEntity) {
        self.interval = interval
        self.activeInterval = .init(intervalID: interval.id)
    }
    
    public func sendSignal(action: DelegateAction) {
        self.delegateActionHandler?(action)
    }
    
    func removeScreen() {}
    
    func tapPauseButton() {
        workoutUseCase.pauseWorkout()
    }
    
    func tapReStartButton() {
        workoutUseCase.resumeWorkout()
    }
    
    func tapEndButton() {
        workoutUseCase.endWorkout()
        
        let newIntervalrecord = IntervalRecordEntity(
            id: .init(),
            heartRates: heartRates, // HealthKit의 평균심박수
            repeatedCount: currentCount,
            secondTime: Int(totalSecondTime),
            createDate: .now,
            calorie: calorie)
        
        intervalRecordUseCase.appendIntervalRecord(intervalId: interval.id, record: newIntervalrecord)
    }
    
    private func formatTotalTimeInterval(timeInterval: TimeInterval) -> String {
        let hours = Int(timeInterval) / 3600
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        let milliseconds = Int(timeInterval.truncatingRemainder(dividingBy: 1) * 100)

        return String(format: "%02d:%02d:%02d.%02d", hours, minutes, seconds, milliseconds)
    }
    
    private func formatCurrentTimeInterval(timeInterval: TimeInterval) -> String {
        let minutes = Int(timeInterval) / 60 % 60
        let seconds = Int(timeInterval) % 60
        let milliseconds = Int(timeInterval.truncatingRemainder(dividingBy: 1) * 100)

        return String(format: "%02d:%02d.%02d", minutes, seconds, milliseconds)
    }
    
    func setupTimer() {
        timerSubscription = timerPublisher
            .sink { [weak self] _ in
                guard let `self` = self else { return }
                
                print(self.workoutSessionState)
                
                if self.workoutSessionState == .running {
                    let burningCount = TimeInterval(self.activeInterval.burningCount)
                    let restingCount = TimeInterval(self.activeInterval.restingCount)
                    let burningSecondTime = TimeInterval(self.interval.burningSecondTime)
                    let restingSecondTime = TimeInterval(self.interval.restingSecondTime)
                    
                    self.totalSecondTime = Date.now.timeIntervalSince(self.startDate)
                    self.currentSecondTime = (burningSecondTime * burningCount + restingSecondTime * restingCount) - self.totalSecondTime
                    
                    self.totalSecondTimeString = self.formatTotalTimeInterval(timeInterval: totalSecondTime)
                    self.currentSecondTimeString = self.formatCurrentTimeInterval(timeInterval: currentSecondTime)
                    
                    switch self.activeInterval.currentIntervalType {
                    case .burning:
                        if self.currentSecondTime <= 0 {
                            withAnimation(.snappy) {
                                self.currentCount += 1
                                self.activeInterval.restingCount += 1
                                self.activeInterval.currentIntervalType = .resting
                            }
                        }
                    case .resting:
                        if self.currentSecondTime <= 0 {
                            withAnimation(.snappy) {
                                self.currentCount += 1
                                self.activeInterval.burningCount += 1
                                self.activeInterval.currentIntervalType = .burning
                            }
                        }
                    }
                    
                    if self.currentCount > self.interval.repeatCount {
                        self.tapEndButton()
                    }
                }
            }
    }
    
    func subscribeHeartRate() {
        #if os(iOS)
        wcSessionUseCase.observeReceiveMessageValue(key: "HEART_RATE") { (heartRate: Double) in
            withAnimation {
                self.heartRates.append(heartRate)
            }
        }
        #elseif os(watchOS)
        workoutUseCase.subcribeHeartRate { heartRate in
            withAnimation {
                self.heartRates.append(heartRate)
            }
            self.wcSessionUseCase.sendMessage(["HEART_RATE": heartRate])
        }
        #endif
    }
    
    func subscribeCalorie() {
        #if os(iOS)
        wcSessionUseCase.observeReceiveMessageValue(key: "CALORIE") { (calorie: Double) in
            withAnimation {
                self.calorie = Int(calorie)
            }
        }
        #elseif os(watchOS)
        workoutUseCase.subcribeCalorie { calorie in
            withAnimation {
                self.calorie = Int(calorie)
            }
            self.wcSessionUseCase.sendMessage(["CALORIE": calorie])
        }
        #endif
    }
    
    func subscribeWorkoutSessionState() {
        workoutUseCase.subcribeWorkoutSessionState { state in
            self.workoutSessionState = state
        }
    }
}
