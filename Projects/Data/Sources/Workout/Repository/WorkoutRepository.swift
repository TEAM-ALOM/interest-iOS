//
//  WorkoutRepository.swift
//  Data
//
//  Created by 김도형 on 1/23/24.
//

import Foundation
import HealthKit

public final class WorkoutRepository: WorkoutDataSourceInterface {
    internal let dataSource: WorkoutDataSource
    
    public init(dataSource: WorkoutDataSource) {
        self.dataSource = dataSource
    }
    
    public func requestAuthorization() -> Bool {
        return dataSource.requestAuthorization()
    }
    
    public func subcribeHeartRate(updateHandler: @escaping (Double) -> Void) {
        dataSource.subcribeHeartRate(updateHandler: updateHandler)
    }
    
    public func subcribeCalorie(updateHandler: @escaping (Double) -> Void) {
        dataSource.subcribeCalorie(updateHandler: updateHandler)
    }
}
