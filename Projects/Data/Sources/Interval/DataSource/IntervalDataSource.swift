//
//  IntervalDataSource.swift
//  Data
//
//  Created by 송영모 on 11/12/23.
//

import Foundation
import SwiftData
import Domain

public protocol IntervalDataSourceInterface {
    func fetch(id: UUID) -> IntervalPersistentModel?
    func fetches() -> [IntervalPersistentModel]
    func save(
        title: String,
        exerciseId : ExerciseImage.ID,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel
    
    func update(
        at id: UUID,
        title: String,
        exerciseId : ExerciseImage.ID,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel?
    func delete(at id: UUID) -> Bool
}

public final class IntervalDataSource: IntervalDataSourceInterface {
    
    private var context: ModelContext? = PersistentContainer.shared.context
    
    public init() {}
    
    public func fetch(id: UUID) -> IntervalPersistentModel? {
        let predicate = #Predicate<IntervalPersistentModel> {
            $0.id == id
        }
        let descriptor: FetchDescriptor<IntervalPersistentModel> = .init(predicate: predicate)
        let result = try? context?.fetch(descriptor)
        
        return result?.first
    }
    
    public func fetches() -> [IntervalPersistentModel] {
        let descriptor: FetchDescriptor<IntervalPersistentModel> = .init()
        let result = try? context?.fetch(descriptor)
        
        return result ?? []
    }
    
    public func save(
        title: String,
        exerciseId: Domain.ExerciseImage.ID,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel {
        let interval: IntervalPersistentModel = .init(
            title: title,
            exerciseId: exerciseId,
            repeatCount: repeatCount,
            burningSecondTime: burningSecondTime,
            burningHeartIntervalType: burningHeartIntervalType,
            restingSecondTime: restingSecondTime,
            restingHeartIntervalType: restingHeartIntervalType
        )
        
        context?.insert(interval)
        
        return interval
    }
    
    public func update(
        at id: UUID,
        title: String,
        exerciseId : Domain.ExerciseImage.ID,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel? {
        let interval = fetch(id: id)
        interval?.title = title
        interval?.exerciseId = exerciseId
        interval?.repeatCount = repeatCount
        interval?.burningSecondTime = burningSecondTime
        interval?.burningHeartIntervalType = burningHeartIntervalType
        interval?.restingSecondTime = restingSecondTime
        interval?.restingHeartIntervalType = restingHeartIntervalType
        
        try? context?.save()
        
        return interval
    }
    
    public func delete(at id: UUID) -> Bool {
        if let interval = self.fetch(id: id) {
            context?.delete(interval)
            return true
        } else {
            return false
        }
    }
}
