//
//  WorkoutManager+WatchOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(watchOS)
extension WorkoutManager: HKWorkoutSessionDelegate, HKLiveWorkoutBuilderDelegate {
    public func workoutSession(_ workoutSession: HKWorkoutSession, 
                               didChangeTo toState: HKWorkoutSessionState,
                               from fromState: HKWorkoutSessionState,
                               date: Date) {
        workoutState.send(toState)
        
        if toState == .ended {
            builder?.endCollection(withEnd: date) { (success, error) in
                self.builder?.finishWorkout { (workout, error) in
                    self.workout = workout
                }
            }
            
            Task {
                try? await session?.stopMirroringToCompanionDevice()
            }
            intervalData = nil
        }
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    func workoutInWatch(configuration: HKWorkoutConfiguration) async {
        self.session = try? HKWorkoutSession(healthStore: healthStore, configuration: configuration)
        builder = session?.associatedWorkoutBuilder()
        builder?.delegate = self
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        
        session?.delegate = self
        
        let startDate = Date.now
        do {
            try await session?.startMirroringToCompanionDevice()
        } catch {
            print("#function: \(error)")
        }
        self.startDate = startDate
        session?.startActivity(with: startDate)
        self.workoutState.send(session?.state ?? .notStarted)
        builder?.beginCollection(withStart: startDate, completion: { success, error in

        })
    }
    
    public func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return
            }
            
            process(workoutBuilder.statistics(for: quantityType), type: quantityType)
        }
    }
    
    public func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
    
    public func sendActiveInfoData(_ data: Data) {
        session?.sendToRemoteWorkoutSession(data: data, completion: { sucess, error in
            if !sucess {
                print("#function: \(error)")
            }
        })
    }
}
#endif
