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
    
    private var container: ModelContainer?
    public var context: ModelContext?
    
    private init() {
        do {
            container = try ModelContainer(for: IntervalPersistentModel.self, IntervalRecordPersistentModel.self)
            if let container {
                context = ModelContext(container)
            }
        } catch {
            print(error)
        }
    }
}
