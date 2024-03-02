//
//  HKWorkoutUseCase.swift
//  Domain
//
//  Created by 송영모 on 3/2/24.
//

import Foundation
import HealthKit
import WatchConnectivity

import Dependencies

#if os(watchOS)
public protocol WatchWorkoutUseCaseInterface {
    func start() async throws -> Void
    func pause()
    func end()
    
    var heartRateUpdateHandler: (Double) -> Void { get }
    var calorieUpdateHandler: (Double) -> Void { get }
}

public class WatchWorkoutUseCase: NSObject, WatchWorkoutUseCaseInterface {
    public var heartRateUpdateHandler: (Double) -> Void = { _ in }
    public var calorieUpdateHandler: (Double) -> Void = { _ in }
    
    private let healthStore = HKHealthStore()
    private var workout: HKWorkout?
    private var workoutSession: HKWorkoutSession?
    private var workoutSessionState: HKWorkoutSessionState = .notStarted
    
    private var liveWorkoutBuilder: HKLiveWorkoutBuilder?
    
    public init(
        workout: HKWorkout? = nil,
        workoutSession: HKWorkoutSession? = nil
    ) {
        self.workout = workout
        self.workoutSession = workoutSession
    }
    
    public func pause() {
        workoutSession?.pause()
    }
    
    public func resume() {
        workoutSession?.resume()
    }
    
    public func end() {
        workoutSession?.end()
        workout = nil
    }
    
    public func start() async throws -> Void {
        workoutSession?.delegate = self
        liveWorkoutBuilder?.delegate = self
        
        let configuration = HKWorkoutConfiguration()
        configuration.activityType = .running
        configuration.locationType = .outdoor
        
        try await healthStore.requestAuthorization(
            toShare: [ HKQuantityType.workoutType() ],
            read: [
                HKQuantityType.quantityType(forIdentifier: .heartRate)!,
                HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
            ])
        workoutSession = try HKWorkoutSession(
            healthStore: healthStore, configuration: configuration
        )
        liveWorkoutBuilder = workoutSession?.associatedWorkoutBuilder()
        
        
        liveWorkoutBuilder?.dataSource = HKLiveWorkoutDataSource(
            healthStore: healthStore,
            workoutConfiguration: configuration)
        
        let startDate = Date()
        workoutSession?.startActivity(with: startDate)
        try await liveWorkoutBuilder?.beginCollection(at: startDate)
    }
}

extension WatchWorkoutUseCase: TestDependencyKey {
    public static var testValue: WatchWorkoutUseCase = unimplemented()
}

public extension DependencyValues {
    var watchWorkoutUseCase: WatchWorkoutUseCase {
        get { self[WatchWorkoutUseCase.self] }
        set { self[WatchWorkoutUseCase.self] = newValue }
    }
}

extension WatchWorkoutUseCase: HKWorkoutSessionDelegate {
    @MainActor
    public func workoutSession(
        _ workoutSession: HKWorkoutSession,
        didChangeTo toState: HKWorkoutSessionState,
        from fromState: HKWorkoutSessionState,
        date: Date
    ) {
        self.workoutSessionState = toState
        
        if toState == .ended {
            liveWorkoutBuilder?.endCollection(withEnd: date) { [weak self] (success, error) in
                debugPrint("live workout builder end collection \(success) \(String(describing: error))")
                self?.liveWorkoutBuilder?.finishWorkout { (workout, error) in
                    DispatchQueue.main.async {
                        self?.workout = workout
                    }
                    debugPrint("live workout builder finish workout \(String(describing: workout)) \(String(describing: error))")
                }
            }
        }
        
        debugPrint("workout session didChangedTo \(toState) from \(fromState)")
    }
    
    public func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        debugPrint("workout session: \(workoutSession) error: \(error)")
    }
}

extension WatchWorkoutUseCase: HKLiveWorkoutBuilderDelegate {
    public func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        debugPrint("workout builder did collect event: \(workoutBuilder)")
    }
    
    @MainActor
    public func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder,
                               didCollectDataOf collectedTypes: Set<HKSampleType>) {
        debugPrint("workout builder did collect data of: \(workoutBuilder) did")
        for type in collectedTypes {
            guard let quantityType = type as? HKQuantityType,
                  let statistics = workoutBuilder.statistics(for: quantityType)
            else { return }
            
            debugPrint("collectedType \(statistics.quantityType)")
            switch statistics.quantityType {
            case HKQuantityType.quantityType(forIdentifier: .heartRate):
                let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
                let heartRate = statistics.mostRecentQuantity()?.doubleValue(for: heartRateUnit) ?? 0
                self.heartRateUpdateHandler(heartRate)
                
                debugPrint("heart \(heartRate)")
                
            case HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned):
                let calorieUnit = HKUnit.kilocalorie()
                let calorie = statistics.sumQuantity()?.doubleValue(for: calorieUnit) ?? 0
                self.calorieUpdateHandler(calorie)
                debugPrint("calorie \(calorie)")
            default:
                return
            }
        }
    }
}
#endif
