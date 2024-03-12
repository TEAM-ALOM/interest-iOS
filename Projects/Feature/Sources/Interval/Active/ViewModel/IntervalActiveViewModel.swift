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
        interval: IntervalEntity?
    ) {
        self.router = router
        super.init(interval: interval)
    }
    
    override func tapEndButton(){
        super.tapEndButton()
    }
    
    override func checkWorkoutSessionState() {
        switch self.workoutSessionState {
        case .ended:
            timerSubscription?.cancel()
            activeIntervalCancellable?.cancel()
            self.router.removeScreenTransition()
        default:
            break
        }
    }
    
    override func subscribeWorkoutSessionState() {
        super.subscribeWorkoutSessionState()
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
    
    @ObservationIgnored var timer: Timer?
    @ObservationIgnored var totalSecondTime: TimeInterval = 0
    @ObservationIgnored var currentSecondTime: TimeInterval = 0
    @ObservationIgnored var timerSubscription: AnyCancellable?
    @ObservationIgnored var activeIntervalCancellable: AnyCancellable?
    @ObservationIgnored private let timerPublisher = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @ObservationIgnored private let activeIntervalPublihser = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var activeInterval: ActiveIntervalEntity
    var isBounce : Bool = true
    var currentCount : Int = 1
    var workoutSessionState: WorkoutSessionState = .running
    var heartRates: [Double] = []
    var calorie : Int = 0
    
    var currentSecondTimeString = "00:00.00"
    var totalSecondTimeString = "00:00:00.00"
    var currentSection: Int = 0
    
    init(interval: IntervalEntity? = nil) {
        if let interval {
            self.activeInterval = .init(
                burningSecondTime: interval.burningSecondTime,
                restingSecondTime: interval.restingSecondTime,
                repeatCount: interval.repeatCount,
                intervalId: interval.id,
                intervalTitle: interval.title,
                burningHeartIntervalType: interval.burningHeartIntervalType,
                restingHeartIntervalType: interval.restingHeartIntervalType)
        } else {
            self.activeInterval = .init(
                burningSecondTime: 0,
                restingSecondTime: 0,
                repeatCount: 0)
        }
    }
    
    public func sendSignal(action: DelegateAction) {
        self.delegateActionHandler?(action)
    }
    
    func tapPauseButton() {
        workoutUseCase.pauseWorkout()
    }
    
    func tapReStartButton() {
        workoutUseCase.resumeWorkout()
    }
    
    func tapEndButton() {
        workoutUseCase.endWorkout()
        
        guard let intervalId = activeInterval.intervalId else {
            return
        }
        
        let newIntervalrecord = IntervalRecordEntity(
            id: .init(),
            heartRates: heartRates, // HealthKit의 평균심박수
            repeatedCount: currentCount,
            secondTime: Int(totalSecondTime),
            createDate: .now,
            calorie: calorie)
        
        intervalRecordUseCase.appendIntervalRecord(intervalId: intervalId, record: newIntervalrecord)
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
                guard let `self` = self,
                      self.workoutSessionState == .running,
                      self.activeInterval.intervalId != nil else {
                    return
                }
                
                let burningCount = TimeInterval(self.activeInterval.burningCount)
                let restingCount = TimeInterval(self.activeInterval.restingCount)
                let burningSecondTime = TimeInterval(self.activeInterval.burningSecondTime)
                let restingSecondTime = TimeInterval(self.activeInterval.restingSecondTime)
                
                self.totalSecondTime = Date.now.timeIntervalSince(self.activeInterval.startDate)
                
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
                
                if self.currentCount > self.activeInterval.repeatCount {
                    self.tapEndButton()
                }
            }
    }
    
    func sendActiveInterval() {
        activeIntervalCancellable = activeIntervalPublihser
            .sink { [weak self] _ in
                guard let `self` = self,
                      self.workoutSessionState == .running else {
                    return
                }
                self.wcSessionUseCase.sendMessage(["ACTIVE_INTERVAL": self.activeInterval])
            }
    }
    
    func subscribeReceivedMessage() {
        wcSessionUseCase.subscribeReceivedMessage { message in
            withAnimation {
#if os(iOS)
                if let heartRate = message["HEART_RATE"] as? Double {
                    self.heartRates.append(heartRate)
                    self.currentSection = HeartIntervalType.currentSection(heartRate: heartRate)
                }
                
                if let calorie = message["CALORIE"] as? Double {
                    self.calorie = Int(calorie)
                }
                
                if let startDate = message["WORKOUT_START"] as? Date {
                    self.workoutUseCase.setWorkoutStartDate(date: startDate)
                }
#endif
                if let activeInterval = message["ACTIVE_INTERVAL"] as? ActiveIntervalEntity {
#if os(iOS)
                    self.activeInterval.currentIntervalType = activeInterval.currentIntervalType
                    self.activeInterval.currentIntervalCount = activeInterval.currentIntervalCount
                    self.activeInterval.restingCount = activeInterval.restingCount
                    self.activeInterval.burningCount = activeInterval.burningCount
                    self.activeInterval.startDate = activeInterval.startDate
#elseif os(watchOS)
                    self.activeInterval.burningSecondTime = activeInterval.burningSecondTime
                    self.activeInterval.restingSecondTime = activeInterval.restingSecondTime
                    self.activeInterval.repeatCount = activeInterval.repeatCount
                    self.activeInterval.intervalId = activeInterval.intervalId
                    self.activeInterval.intervalTitle = activeInterval.intervalTitle
                    self.activeInterval.burningHeartIntervalType = activeInterval.burningHeartIntervalType
                    self.activeInterval.restingHeartIntervalType = activeInterval.restingHeartIntervalType
#endif
                    print("\(#function) \(activeInterval)")
                }
            }
        }
    }
    
    func unsubscribeReceivedMessage() {
        wcSessionUseCase.unsubcribeReceivedMessage()
    }
    
#if os(watchOS)
    func subscribeHeartRate() {
        workoutUseCase.subcribeHeartRate { heartRate in
            withAnimation {
                self.heartRates.append(heartRate)
                self.currentSection = HeartIntervalType.currentSection(heartRate: heartRate)
            }
            self.wcSessionUseCase.sendMessage(["HEART_RATE": heartRate])
        }
    }
    
    func subscribeCalorie() {
        workoutUseCase.subcribeCalorie { calorie in
            withAnimation {
                self.calorie = Int(calorie)
            }
            self.wcSessionUseCase.sendMessage(["CALORIE": calorie])
        }
    }
#endif
    
    func subscribeWorkoutSessionState() {
        workoutUseCase.subcribeWorkoutSessionState { state in
            self.workoutSessionState = state
            self.checkWorkoutSessionState()
            print(self.workoutSessionState)
        }
    }
    
    func checkWorkoutSessionState() { }
    
    func unsubscribeWorkoutSessionInfo() {
        workoutUseCase.unsubscribeWorkoutSessionInfo()
    }
}

private extension HeartIntervalType {
    static func currentSection(heartRate: Double) -> Int {
        switch heartRate {
        case 0...134:
            return 1
        case 135...148:
            return 2
        case 149...162:
            return 3
        case 163...175:
            return 4
        default:
            return 5
        }
    }
}
