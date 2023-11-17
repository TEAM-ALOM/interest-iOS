//
//  CompositionRoot.swift
//  InterestApp
//
//  Created by 최유경 on 11/18/23.
//

import Foundation
import WatchPresentation

public protocol CompositionRootInterface {
    var intervalDIContainer: WatchIntervalDIContainerInterface { get }
}

public final class CompositionRoot: CompositionRootInterface {
    public let intervalDIContainer: WatchIntervalDIContainerInterface
    
    public init() {
        self.intervalDIContainer = WatchIntervalDIContainer()
    }
}
