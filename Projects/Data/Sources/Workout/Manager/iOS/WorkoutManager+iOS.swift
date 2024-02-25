//
//  WorkoutManager+iOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(iOS)
extension WorkoutManager: HKWorkoutSessionDelegate{
    public func workoutSession(_ workoutSession: HKWorkoutSession,
                               didChangeTo toState: HKWorkoutSessionState,
                               from fromState: HKWorkoutSessionState,
                               date: Date) {
        workoutState.send(toState)
        if toState == .ended {
            intervalData = nil
        }
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didBeginActivityWith workoutConfiguration: HKWorkoutConfiguration, date: Date) {
        self.startDate = date
    }
    
    func workoutInPhone(configuration: HKWorkoutConfiguration) async {
        do {
            try await healthStore.startWatchApp(toHandle: configuration)
        } catch {
            print(error)
            return
        }
        
        healthStore.workoutSessionMirroringStartHandler = { mirroredSession in
            print(mirroredSession)
            self.session = mirroredSession
            mirroredSession.delegate = self
            self.workoutState.send(mirroredSession.state)
        }
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didReceiveDataFromRemoteWorkoutSession data: [Data]) {
        guard let recentData = data.last else {
            return
        }
        
        activeInfoData.send(recentData)
    }
    
    func subscribeActiveInfoData(updateHandler: @escaping (Data) -> Void) {
        self.activeInfoData
            .removeDuplicates()
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
}
#endif
