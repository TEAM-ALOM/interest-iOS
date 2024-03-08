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
            self.interval = nil
            break
        default:
            break
        }
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    func workoutSessionMirroring() {
        healthStore.workoutSessionMirroringStartHandler = { mirroredSession in
            self.session = mirroredSession
            self.session?.delegate = self
            self.startDate = .now
            self.workoutSessionState.send(mirroredSession.state)
        }
    }
    
    func workoutInPhone(configuration: HKWorkoutConfiguration) {
        healthStore.startWatchApp(with: configuration) { success, error in
            print("\(#function) \(success)")
        }
    }
}
#endif
