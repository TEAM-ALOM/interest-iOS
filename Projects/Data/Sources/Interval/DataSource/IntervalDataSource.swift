//
//  IntervalDataSource.swift
//  Data
//
//  Created by 송영모 on 11/12/23.
//

import Foundation
import SwiftData

public protocol IntervalDataSourceInterface {
    func fetchInterval(id: UUID) -> IntervalPersistentModel?
    func fetchIntervals() -> [IntervalPersistentModel]
    func saveInterval(
        title: String,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel
    func updateInterval(
        at id: UUID,
        title: String,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel?
    func deleteInterval(at id: UUID) -> Bool
}

public final class IntervalDataSource: IntervalDataSourceInterface {
    private var context: ModelContext? = PersistentContainer.shared.context
    
    public init() {}
    
    public func fetchInterval(id: UUID) -> IntervalPersistentModel? {
        let predicate = #Predicate<IntervalPersistentModel> {
            $0.id == id
        }
        let descriptor: FetchDescriptor<IntervalPersistentModel> = .init(predicate: predicate)
        let result = try? context?.fetch(descriptor)
        
        return result?.first
    }
    
    public func fetchIntervals() -> [IntervalPersistentModel] {
        let descriptor: FetchDescriptor<IntervalPersistentModel> = .init()
        let result = try? context?.fetch(descriptor)
        
        return result ?? []
    }
    
    public func saveInterval(
        title: String,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel {
        let interval: IntervalPersistentModel = .init(
            title: title,
            repeatCount: repeatCount,
            burningSecondTime: burningSecondTime,
            burningHeartIntervalType: burningHeartIntervalType,
            restingSecondTime: restingSecondTime,
            restingHeartIntervalType: restingHeartIntervalType
        )
        context?.insert(interval)
        
        return interval
    }
    
    public func updateInterval(
        at id: UUID,
        title: String,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel? {
        let interval = fetchInterval(id: id)
        interval?.title = title
        interval?.repeatCount = repeatCount
        interval?.burningSecondTime = burningSecondTime
        interval?.burningHeartIntervalType = burningHeartIntervalType
        interval?.restingSecondTime = restingSecondTime
        interval?.restingHeartIntervalType = restingHeartIntervalType
        try? context?.save()
        
        return interval
    }
    
    public func deleteInterval(at id: UUID) -> Bool {
        if let interval = self.fetchInterval(id: id) {
            context?.delete(interval)
            return true
        } else {
            return false
        }
    }
}
