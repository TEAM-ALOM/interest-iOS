//
//  PersistentModelManager.swift
//  Data
//
//  Created by 송영모 on 11/29/23.
//

import Foundation
import SwiftData

public class PersistentContainer {
    public static let shared = PersistentContainer()

    public var context: ModelContext? {
        if let container = try? ModelContainer(for: IntervalPersistentModel.self, IntervalRecordPersistentModel.self) {
            return ModelContext(container)
        } else {
            return nil
        }
    }
    
    private init() { }
}
