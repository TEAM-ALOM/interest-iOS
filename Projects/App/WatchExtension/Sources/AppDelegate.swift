//
//  AppDelegate.swift
//  InterestWatchExtension
//
//  Created by 김도형 on 2/26/24.
//

import Foundation
import Combine
import WatchKit
import HealthKit
import Feature
import Domain
import Dependencies
import Perception

class AppDelegate: NSObject, WKApplicationDelegate, WKExtensionDelegate {
    @Dependency(\.workoutUseCase) var workoutUseCase
    @Dependency(\.wcSessionUseCase) var wcSessionUseCase
    @Dependency(\.intervalUseCase) var intervalUseCase
    
    var startWatchAppFromiPhone = PassthroughSubject<Bool, Never>()
    
    func handle(_ workoutConfiguration: HKWorkoutConfiguration) {
        startWatchAppFromiPhone.send(true)
    }
    
    func subscribeStartWatchAppFromiPhone() {
        startWatchAppFromiPhone
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                if value {
                    self.startWorkout()
                }
            }
            .cancel()
    }
    
    func startWorkout() {
        wcSessionUseCase.sendMessage(["WATCH_READY": true])
    }
    
    func subsrcibeStartedInterval() {
        wcSessionUseCase.observeReceiveMessageValue(key: "INTERVAL_ID") { [weak self] (id: String) in
            guard let `self` = self else { return }
            // 임시로 샘플 인터벌을 생성하여 테스트를 진행하였음
            self.workoutUseCase.startWorkout(interval: .init(id: UUID(uuidString: id)!))
        }
    }
}
