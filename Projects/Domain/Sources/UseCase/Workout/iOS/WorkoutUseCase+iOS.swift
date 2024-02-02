//
//  WorkoutUseCase+iOS.swift
//  Domain
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(iOS)
public extension WorkoutUseCase {
    func fetchHealthKitData(type: HKQuantityTypeIdentifier) async {
        await repository.fetchHealthKitData(type: type)
    }
}
#endif
