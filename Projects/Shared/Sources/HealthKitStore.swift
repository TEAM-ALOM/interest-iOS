//
//  HealthKitManager.swift
//  Shared
//
//  Created by 송영모 on 3/2/24.
//

import Foundation
import HealthKit

public struct HealthKitStore {
    public let healthStore: HKHealthStore
    
    var toShare: Set<HKSampleType>
    var toRead: Set<HKSampleType>
    
    public init(
        healthStore: HKHealthStore = .init(),
        toShare: Set<HKSampleType> = .init([
            HKQuantityType.quantityType(forIdentifier: .heartRate)!,
            HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!,
        ]),
        toRead: Set<HKSampleType> = .init([
            HKQuantityType.workoutType()
        ])
    ) {
        self.healthStore = healthStore
        self.toShare = toShare
        self.toRead = toRead
    }
    
    /// HealthKit에 대한 인증을 진행하고, 백그라운드 딜리버리를 등록합니다.
    ///
    /// - Parameters:
    ///   - toShare: 쓰기 목록
    ///   - toRead: 읽기 목록
    public func requestAuthorizationAndRegisterBackgroundDelivery(
        toShare: Set<HKSampleType>? = nil,
        toRead: Set<HKSampleType>? = nil
    ) {
        requestAuthorization(
            toShare: toShare ?? self.toShare,
            toRead: toRead ?? self.toRead
        ) { success, errorOrNil in
            self.registerBackgroundDelivery(targets: toRead)
        }
    }
    
    /// HKSampleType에 대한 변경 점을 Observe 하여, 데이터를 계속해서 받아옵니다.
    ///
    /// - Parameters:
    ///   - toObserve: 구독 목록
    ///   - updateAnchorQueryHandler: 업데이트 핸들러
    public func requestObserverQuery(
        toObserve: Set<HKSampleType>? = nil,
        updateAnchorQueryHandler: @escaping (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void
    ) {
        let readDataTypes = toObserve ?? self.toRead
        
        for readDataType in readDataTypes {
            let query = HKObserverQuery(sampleType: readDataType, predicate: nil) { query, completion, errorOrNil in
                self.requestAnchorQuery(toAnchor: readDataType, updateHandler: updateAnchorQueryHandler)
            }

            self.healthStore.execute(query)
        }
    }
    
    /// HKSampleType에 대한 변경 점을 Observe 하여, 데이터를 계속해서 받아옵니다.
    ///
    /// - Parameters:
    ///   - toAnchor: 구독 목록
    ///   - updateHandler: 업데이트 핸들러
    private func requestAnchorQuery(
        toAnchor: HKSampleType,
        updateHandler: @escaping (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void
    ) {
        let query = HKAnchoredObjectQuery(
            type: toAnchor,
            predicate: nil,
            anchor: nil,
            limit: HKObjectQueryNoLimit,
            resultsHandler: updateHandler)
        
        healthStore.execute(query)
    }

    /// HealthKit에 대한 접근 권한을 얻습니다.
    ///
    /// - Parameters:
    ///   - toAnchor: 구독 목록
    ///   - updateHandler: 업데이트 핸들러
    public func requestAuthorization(
        toShare: Set<HKSampleType>? = nil,
        toRead: Set<HKSampleType>? = nil,
        completion: @escaping (Bool, Error?) -> Void
    ) {
        let shareDataTypes = toShare ?? self.toShare
        let readDataTypes = toRead ?? self.toRead
        
        healthStore.requestAuthorization(
            toShare: shareDataTypes,
            read: readDataTypes,
            completion: completion
        )
    }
    
    /// HKSampleType에 대한 백그라운드 딜리버리를 등록합니다.
    ///
    /// - Parameters:
    ///   - targets: 등록할 타겟
    private func registerBackgroundDelivery(targets: Set<HKSampleType>? = nil) {
        let readDataTypes = targets ?? self.toRead
        
        for readDataType in readDataTypes {
            self.healthStore.enableBackgroundDelivery(
                for: readDataType,
                frequency: .immediate,
                withCompletion: { (success, errorOrNil) in
                    debugPrint("register background delivery \(success)")
                }
            )
        }
    }
}
