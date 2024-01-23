//
//  WorkoutManager.swift
//  Data
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import HealthKit
import Combine

public class WorkoutManager: NSObject {
    internal var healthStore = HKHealthStore()
    internal var hearRate = PassthroughSubject<Double, Never>()
    internal var calorie = PassthroughSubject<Double, Never>()
    private var cancellable = Set<AnyCancellable>()
    private var healthKitTypes: Set<HKQuantityType> = [
        HKQuantityType(.heartRate),
        HKQuantityType(.activeEnergyBurned)
    ]
    #if os(watchOS)
    internal var session: HKWorkoutSession?
    internal var builder: HKLiveWorkoutBuilder?
    #endif
    
    public override init() { }
    
    public func requestAuthorization() -> Bool {
        var result = false
        
        healthStore.requestAuthorization(toShare: [], read: healthKitTypes) { success, error in
            result = success
        }
        
        if result {
            let sampleTypes = healthKitTypes.map { type in
                return type as HKSampleType
            }
            for type in sampleTypes {
                self.healthStore.enableBackgroundDelivery(
                    for: type,
                    frequency: .immediate,
                    withCompletion: { (success, errorOrNil) in
                        
                    }
                )
            }
        }
        
        return result
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        self.hearRate
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        self.calorie
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    internal func process(_ quantity: HKQuantity,
                          type: HKQuantityType) {
        switch type {
        case HKQuantityType(.heartRate):
            let value = quantity.doubleValue(for: HKUnit(from: "count/min"))
            hearRate.send(value)
            break
        case HKQuantityType(.activeEnergyBurned):
            let value = quantity.doubleValue(for: HKUnit.kilocalorie())
            calorie.send(value)
            break
        default:
            break
        }
    }
}
