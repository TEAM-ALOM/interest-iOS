//
//  RouterDIContainer.swift
//  Interest
//
//  Created by 최유경 on 1/17/24.
//

import Foundation
import Presentation

public final class RouterDIContainer: RouterDIContainerInterface {
    public func intervalRouter(intervalDIContainer: IntervalDIContainerInterface) -> IntervalRouter {
        return IntervalRouter(intervalDIContainer: intervalDIContainer)
    }
}
