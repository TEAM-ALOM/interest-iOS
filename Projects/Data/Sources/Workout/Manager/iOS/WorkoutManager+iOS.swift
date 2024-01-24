//
//  WorkoutManager+iOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(iOS)
extension WorkoutManager {
    func healthKitDataQuery(type: HKQuantityTypeIdentifier) async {
        let completionHandler: (HKStatisticsQuery,
                                HKStatistics?,
                                Error?) -> Void = { query, statistics, error in
            self.process(statistics, type: HKQuantityType(type))
        }
        
        let query = HKStatisticsQuery(quantityType: HKQuantityType(type),
                                      quantitySamplePredicate: nil,
                                      options: .mostRecent,
                                      completionHandler: completionHandler)
        
        healthStore.execute(query)
    }
}
#endif
