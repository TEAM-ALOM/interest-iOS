//
//  WorkoutManager.swift
//  Data
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import HealthKit
import WorkoutKit
import Combine

public class WorkoutManager: NSObject {
    static let shared = WorkoutManager()
    
    var healthStore = HKHealthStore()
    var hearRate = PassthroughSubject<Double, Never>()
    var calorie = PassthroughSubject<Double, Never>()
    var activeInfoData = PassthroughSubject<Data, Never>()
    var workoutState = PassthroughSubject<HKWorkoutSessionState, Never>()
    var cancellable = Set<AnyCancellable>()
    var intervalData: Data?
    var startDate: Date?
    
    private var healthKitTypes: Set = [
        HKQuantityType(.heartRate),
        HKQuantityType(.activeEnergyBurned),
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
        
        healthStore.requestAuthorization(toShare: typesToShare,
                                         read: healthKitTypes) { success, error in
            result = success
        }
        return result
    }
    
    func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        self.hearRate
            .removeDuplicates()
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        self.calorie
            .removeDuplicates()
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    func subscribeWorkoutState(updateHandler: @escaping (HKWorkoutSessionState) -> Void) {
        self.workoutState
            .removeDuplicates()
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { value in
                updateHandler(value)
            }
            .store(in: &cancellable)
    }
    
    func startWorkout(intervalData: Data, workoutType: HKWorkoutActivityType) {
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = workoutType
        Task {
#if os(watchOS)
            await self.workoutInWatch(configuration: configuration)
#elseif os(iOS)
            await self.workoutInPhone(configuration: configuration)
#endif
        }
        self.intervalData = intervalData
    }
    
    func pauseWorkout() {
        session?.pause()
    }

    func resumeWorkout() {
        session?.resume()
    }

    func endWorkout() {
        session?.end()
        intervalData = nil
        startDate = nil
    }
    
    func workoutStartDate() -> Date? {
        return startDate
    }
    
    func process(_ statistics: HKStatistics?,
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
