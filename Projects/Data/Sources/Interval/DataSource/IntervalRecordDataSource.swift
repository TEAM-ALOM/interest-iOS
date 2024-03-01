//
//  IntervalRecordDataSource.swift
//  Data
//
//  Created by 김도형 on 12/4/23.
//

import Foundation

import Dependencies

import SwiftData

public protocol IntervalRecordDataSourceInterface {
    func fetch(intervalId: UUID, at recordID: UUID) -> IntervalRecordPersistentModel?
    func fetches(intervalId id: UUID) -> [IntervalRecordPersistentModel]
    func append(intervalId id: UUID,
                heartRates: [Double],
                repeatedCount: Int,
                secondTime: Int,
                createDate: Date,
                calorie: Int
    ) -> Void
    func delete(intervalId: UUID, at recordID: UUID) -> Bool
}

public final class IntervalRecordDataSource: IntervalRecordDataSourceInterface {
    private var context: ModelContext? { PersistentContainer.shared.context }
    
    public init() {}
    
    private func intervalFetch(at id: UUID) -> IntervalPersistentModel? {
        let predicate = #Predicate<IntervalPersistentModel>{ interval in
            interval.id == id
        }
        let descriptor: FetchDescriptor<IntervalPersistentModel> = .init(predicate: predicate)
        let result = try? context?.fetch(descriptor)
        
        return result?.first
    }
    
    public func fetch(intervalId: UUID, at recordID: UUID) -> IntervalRecordPersistentModel? {
        let records = self.intervalFetch(at: intervalId)?.records
        let result = records?.first(where: { record in
            return record.id == recordID
        })
        
        return result
    }
    
    public func fetches(intervalId id: UUID) -> [IntervalRecordPersistentModel] {
        let records = self.intervalFetch(at: id)?.records
        
        return records ?? []
    }
    
    public func append(intervalId id: UUID,
                       heartRates: [Double],
                       repeatedCount: Int,
                       secondTime: Int,
                       createDate: Date,
                       calorie: Int
    ) -> Void {
        if let interval = self.intervalFetch(at: id) {
            let record: IntervalRecordPersistentModel = .init(
                interval: interval,
                heartRates: heartRates,
                repeatedCount: repeatedCount,
                secondTime: secondTime,
                createDate: createDate,
                calorie: calorie
            )
            context?.insert(record)
            try? context?.save()
        }
    }
    
    public func delete(intervalId: UUID, at recordID: UUID) -> Bool {
        let interval = self.intervalFetch(at: intervalId)
        if let recordIndex = interval?.records?.firstIndex(where: { record in
            return record.id == recordID
        }) {
            interval?.records?.remove(at: recordIndex)
            try? context?.save()
            return true
        } else {
            return false
        }
    }
}
