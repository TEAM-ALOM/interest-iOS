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
    func workoutSessionMirroring() {
        manager.workoutSessionMirroring()
    }
}
#endif
