//
//  WorkoutManager+iOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(iOS)
extension WorkoutManager: HKWorkoutSessionDelegate {
    public func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        workoutSessionState.send(toState)
        switch toState {
        case .running:
            break
        case .ended:
            intervalId = nil
            break
        default:
            break
        }
    }
    
//    public func workoutSession(_ workoutSession: HKWorkoutSession, didBeginActivityWith workoutConfiguration: HKWorkoutConfiguration, date: Date) {
//        self.startDate = date
//        print("\(#function) \(self.startDate)")
//    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    func workoutSessionMirroring(intervalId: UUID) {
        healthStore.workoutSessionMirroringStartHandler = { mirroredSession in
            self.intervalId = intervalId
            self.session = mirroredSession
            self.session?.delegate = self
            self.startDate = mirroredSession.startDate
            self.workoutSessionState.send(mirroredSession.state)
        }
    }
    
    func workoutInPhone(configuration: HKWorkoutConfiguration) {
        healthStore.startWatchApp(with: configuration) { success, error in
            print("\(#function) \(success)")
        }
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didReceiveDataFromRemoteWorkoutSession data: [Data]) {
        guard let recentData = data.last else {
            return
        }
        activeInterval.send(recentData)
    }
}
#endif
