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
        workoutSessionState.send(toState)
        switch toState {
        case .running:
            break
        case .ended:
            builder?.endCollection(withEnd: date) { (success, error) in
                self.builder?.finishWorkout { (workout, error) in
                    self.workout = workout
                }
            }
            
            session?.stopMirroringToCompanionDevice { sucesss, error in
                
            }
            break
        default:
            break
        }
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        
    }
    
    func workoutInWatch(configuration: HKWorkoutConfiguration) {
        self.session = try? HKWorkoutSession(healthStore: healthStore, configuration: configuration)
        builder = session?.associatedWorkoutBuilder()
        builder?.delegate = self
        
        builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: configuration)
        
        session?.delegate = self
        
        workoutSessionState.send(session?.state ?? .prepared)
        let startDate = Date()
        self.startDate = startDate
        session?.startActivity(with: startDate)
        session?.startMirroringToCompanionDevice(completion: { success, error in
            print("\(#function) \(success)")
        })
        
        builder?.beginCollection(withStart: startDate, completion: { success, error in
            
        })
    }
    
    public func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        print(#function)
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
