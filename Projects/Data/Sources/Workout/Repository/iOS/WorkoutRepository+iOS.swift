//
//  WorkoutRepository+iOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(iOS)
public extension WorkoutRepository {
    func fetchHealthKitData(type: HKQuantityTypeIdentifier) async {
        await dataSource.fetchHealthKitData(type: type)
    }
}
#endif
