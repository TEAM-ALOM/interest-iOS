//
//  WorkoutRepository+iOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import Domain

#if os(iOS)
public extension WorkoutRepository {
    func subcribeActiveInterval(updateHandler: @escaping (ActiveIntervalEntity) -> Void) {
        dataSource.subcribeActiveInterval(updateHandler: updateHandler)
    }
    
    func workoutSessionMirroring(intervalId: UUID) {
        dataSource.workoutSessionMirroring(intervalId: intervalId)
    }
}
#endif
