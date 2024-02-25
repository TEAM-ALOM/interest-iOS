//
//  WorkoutState.swift
//  Domain
//
//  Created by 김도형 on 2/23/24.
//

import Foundation
import HealthKit

public enum WorkoutState {
    case notStarted
    case running
    case ended
    case paused
    case prepared
    case stopped
}
