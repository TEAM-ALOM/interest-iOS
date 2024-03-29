//
//  IntervalDataSource.swift
//  Data
//
//  Created by 송영모 on 11/12/23.
//

import Foundation
import SwiftData

import Dependencies

import Domain

public protocol IntervalDataSourceInterface {
    func fetch(id: UUID) -> IntervalPersistentModel?
    func fetches() -> [IntervalPersistentModel]
    func save(
        title: String,
        exerciseType: ExerciseTypePersistentModel,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> Bool
    
    func update(
        at id: UUID,
        title: String,
        exerciseType: ExerciseTypePersistentModel,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel?
    func delete(at id: UUID) -> Bool
}

public final class IntervalDataSource: IntervalDataSourceInterface {
    private var context: ModelContext? { PersistentContainer.shared.context }
    
    public init() {}
    
    public func fetch(id: UUID) -> IntervalPersistentModel? {
        let predicate = #Predicate<IntervalPersistentModel> {
            $0.id == id
        }
        let descriptor: FetchDescriptor<IntervalPersistentModel> = .init(predicate: predicate)
        let result = try? self.context?.fetch(descriptor)
        
        return result?.first
    }
    
    public func fetches() -> [IntervalPersistentModel] {
        let descriptor: FetchDescriptor<IntervalPersistentModel> = .init()
        let result: [IntervalPersistentModel]
        do {
            result = try self.context?.fetch(descriptor) ?? []
            return result
        } catch {
            print(error)
        }
        return []
    }
    
    public func save(
        title: String,
        exerciseType: ExerciseTypePersistentModel,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> Bool {
        self.context?.insert(IntervalPersistentModel.init(
            title: title,
            exerciseType: exerciseType,
            repeatCount: repeatCount,
            burningSecondTime: burningSecondTime,
            burningHeartIntervalType: burningHeartIntervalType,
            restingSecondTime: restingSecondTime,
            restingHeartIntervalType: restingHeartIntervalType
        ))
        
        return true
    }
    
    public func update(
        at id: UUID,
        title: String,
        exerciseType: ExerciseTypePersistentModel,
        repeatCount: Int,
        burningSecondTime: Int,
        burningHeartIntervalType: HeartIntervalTypePresistentModel,
        restingSecondTime: Int,
        restingHeartIntervalType: HeartIntervalTypePresistentModel
    ) -> IntervalPersistentModel? {
        let interval = fetch(id: id)
        interval?.title = title
        interval?.exerciseType = exerciseType
        interval?.repeatCount = repeatCount
        interval?.burningSecondTime = burningSecondTime
        interval?.burningHeartIntervalType = burningHeartIntervalType
        interval?.restingSecondTime = restingSecondTime
        interval?.restingHeartIntervalType = restingHeartIntervalType
        
        try? self.context?.save()
        
        return interval
    }
    
    public func delete(at id: UUID) -> Bool {
        if let interval = self.fetch(id: id) {
            interval.modelContext?.delete(interval)
            
            try? interval.modelContext?.save()
    
            return true
        } else {
            return false
        }
    }
}

extension IntervalDataSource: TestDependencyKey {
    public static var testValue: IntervalDataSource = unimplemented()
}

public extension DependencyValues {
    var intervalDataSource: IntervalDataSource {
        get { self[IntervalDataSource.self] }
        set { self[IntervalDataSource.self] = newValue }
    }
}

extension IntervalDataSource: DependencyKey {
    public static var liveValue: IntervalDataSource = .init()
}
