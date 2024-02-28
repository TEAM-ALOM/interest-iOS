//
//  WorkoutUseCase+iOS.swift
//  Domain
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

#if os(iOS)
extension WorkoutUseCase {
    public func subcribeActiveInterval(updateHandler: @escaping (ActiveIntervalEntity) -> Void) {
        workoutRepository.subcribeActiveInterval(updateHandler: updateHandler)
    }
    
    public func workoutSessionMirroring(intervalId: UUID) {
        workoutRepository.workoutSessionMirroring(intervalId: intervalId)
    }
}
#endif
