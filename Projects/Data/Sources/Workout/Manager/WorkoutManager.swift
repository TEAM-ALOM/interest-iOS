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
    private var healthKitTypes: Set = [
        HKQuantityType(.heartRate),
        HKQuantityType(.activeEnergyBurned),
        HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!,
        HKObjectType.activitySummaryType()
    ]
    private var typesToShare: Set = [
        HKQuantityType.workoutType()
    ]

    internal var workout: HKWorkout?
    #if os(watchOS)
    internal var session: HKWorkoutSession?
    internal var builder: HKLiveWorkoutBuilder?
    #endif
    
    public override init() { }
    
    func requestAuthorization() -> Bool {
        var result = false
        
        healthStore.requestAuthorization(toShare: typesToShare, read: healthKitTypes) { success, error in
            result = success
        }
        
        return result
    }
    
    func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        self.hearRate
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        self.calorie
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    internal func process(_ statistics: HKStatistics?,
                          type: HKQuantityType) {
        switch type {
        case HKQuantityType(.heartRate):
            guard let quantity = statistics?.mostRecentQuantity() else {
                break
            }
            let value = quantity.doubleValue(for: HKUnit(from: "count/min"))
            hearRate.send(value)
            break
        case HKQuantityType(.activeEnergyBurned):
            guard let quantity = statistics?.sumQuantity() else {
                break
            }
            let value = quantity.doubleValue(for: HKUnit.kilocalorie())
            calorie.send(value)
            break
        default:
            break
        }
    }
}