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
    static let shared = WorkoutManager()
    
    var healthStore = HKHealthStore()
    var hearRate = PassthroughSubject<Double, Never>()
    var calorie = PassthroughSubject<Double, Never>()
    var workoutSessionState = PassthroughSubject<HKWorkoutSessionState, Never>()
    var activeInterval = PassthroughSubject<Data, Never>()
    var intervalId: UUID?
    var startDate: Date?
    
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
    internal var session: HKWorkoutSession?
    #if os(watchOS)
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
            .removeDuplicates()
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        self.calorie
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    func subcribeWorkoutSessionState(updateHandler: @escaping (HKWorkoutSessionState) -> Void) {
        self.workoutSessionState
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    func subcribeActiveInterval(updateHandler: @escaping (Data) -> Void) {
        self.activeInterval
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .removeDuplicates()
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    func startWorkout(workoutType: HKWorkoutActivityType, intervalId: UUID) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        self.intervalId = intervalId
#if os(watchOS)
        self.workoutInWatch(configuration: configuration)
#elseif os(iOS)
        self.workoutInPhone(configuration: configuration)
#endif
    }
    
    func pauseWorkout() {
        session?.pause()
    }

    func resumeWorkout() {
        session?.resume()
    }

    func endWorkout() {
        session?.end()
    }
    
    func workoutIntervalId() -> UUID? {
        return intervalId
    }
    
    func workoutStartDate() -> Date? {
        return startDate
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
