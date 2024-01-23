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
    public func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    public func startWorkout(workoutType: HKWorkoutActivityType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        configuration.locationType = .outdoor
        
        self.session = try? HKWorkoutSession(healthStore: healthStore, configuration: configuration)
        builder = session?.associatedWorkoutBuilder()
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        
        session?.delegate = self
        builder?.delegate = self
        
        let startDate = Date()
        session?.startActivity(with: startDate)
        builder?.beginCollection(withStart: startDate, completion: { success, error in
            
        })
    }
    
    public func pauseWorkout() {
        session?.pause()
    }

    public func resumeWorkout() {
        session?.resume()
    }

    public func endWorkout() {
        session?.end()
    }
    
    public func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType else {
                return
            }
            
            guard let statistics = workoutBuilder.statistics(for: quantityType) else {
                return
            }
            
            guard let quantity = statistics.mostRecentQuantity() else {
                return
            }
            
            process(quantity, type: quantityType)
        }
    }
    
    public func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        
    }
}
#endif
