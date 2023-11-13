//
//  CompositionRoot.swift
//  InterestApp
//
//  Created by 송영모 on 11/13/23.
//

import Foundation
import Presentation

public protocol CompositionRootInterface {
    var intervalDIContainer: IntervalDIContainerInterface { get }
}

public final class CompositionRoot: CompositionRootInterface {
    public let intervalDIContainer: IntervalDIContainerInterface
    
    public init() {
        self.intervalDIContainer = IntervalDIContainer()
    }
}
