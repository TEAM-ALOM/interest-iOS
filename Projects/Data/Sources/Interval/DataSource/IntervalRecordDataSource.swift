//
//  IntervalRecordDataSource.swift
//  Data
//
//  Created by 김도형 on 12/4/23.
//

import Foundation
import SwiftData

public protocol IntervalRecordDataSourceInterface {
    func fetch(intervalID: UUID, at recordID: UUID) -> IntervalRecordPersistentModel?
    func fetches(intervalID id: UUID) -> [IntervalRecordPersistentModel]
    func append(intervalID id: UUID,
              heartRates: [Double],
              repeatedCount: Int,
              secondTime: Int) -> IntervalRecordPersistentModel
    func delete(intervalID: UUID, at recordID: UUID) -> Bool
}

public final class IntervalRecordDataSource: IntervalRecordDataSourceInterface {
    private var context: ModelContext? = PersistentContainer.shared.context
    
    public init() {}
    
    private func intervalFetch(at id: UUID) -> IntervalPersistentModel? {
        let predicate = #Predicate<IntervalPersistentModel>{ interval in
            interval.id == id
        }
        let descriptor: FetchDescriptor<IntervalPersistentModel> = .init(predicate: predicate)
        let result = try? context?.fetch(descriptor)
        
        return result?.first
    }
    
    public func fetch(intervalID: UUID, at recordID: UUID) -> IntervalRecordPersistentModel? {
        let records = self.intervalFetch(at: intervalID)?.records
        let result = records?.first(where: { record in
            return record.id == recordID
        })
        
        return result
    }
    
    public func fetches(intervalID id: UUID) -> [IntervalRecordPersistentModel] {
        let records = self.intervalFetch(at: id)?.records
        
        return records ?? []
    }
    
    public func append(intervalID id: UUID, heartRates: [Double], repeatedCount: Int, secondTime: Int) -> IntervalRecordPersistentModel {
        let interval = self.intervalFetch(at: id)
        let record: IntervalRecordPersistentModel = .init(heartRates: heartRates,
                           repeatedCount: repeatedCount,
                           secondTime: secondTime)
        
        interval?.records?.append(record)
        try? context?.save()
        
        return record
    }
    
    public func delete(intervalID: UUID, at recordID: UUID) -> Bool {
        let interval = self.intervalFetch(at: intervalID)
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
