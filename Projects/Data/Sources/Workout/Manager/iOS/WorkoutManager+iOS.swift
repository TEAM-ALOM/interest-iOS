//
//  WorkoutManager+iOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(iOS)
public extension WorkoutManager {
    func healthKitDataQuery(type: HKQuantityTypeIdentifier) async {
        let completionHandler: (HKStatisticsQuery,
                            HKStatistics?,
                            Error?) -> Void = { query, statistics, error in
            
            self.process(statistics, type: HKQuantityType(type))
        }
        
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        let query = HKStatisticsQuery(quantityType: HKQuantityType(type),
                                      quantitySamplePredicate: devicePredicate,
                                      options: .mostRecent,
                                      completionHandler: completionHandler)
        
        healthStore.execute(query)
    }
}
#endif
