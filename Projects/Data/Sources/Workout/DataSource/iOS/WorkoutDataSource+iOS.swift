//
//  WorkoutDataSource+iOS.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import Domain

#if os(iOS)
public extension WorkoutDataSource {
    func subcribeActiveInterval(updateHandler: @escaping (ActiveIntervalEntity) -> Void) {
        manager.subcribeActiveInterval { data in
            guard let activeInterval = try? JSONDecoder().decode(ActiveIntervalEntity.self, from: data) else {
                return
            }
            updateHandler(activeInterval)
        }
    }
    
    func workoutSessionMirroring(intervalId: UUID) {
        manager.workoutSessionMirroring(intervalId: intervalId)
    }
}
#endif
