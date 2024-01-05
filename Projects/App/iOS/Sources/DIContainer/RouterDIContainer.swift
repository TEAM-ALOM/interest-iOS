//
//  RouterDIContainer.swift
//  InterestApp
//
//  Created by 김도형 on 12/4/23.
//

import Foundation
import Presentation

public final class RouterDIContainer: RouterDIContainerInterface {
    public func intervalRouter(intervalDIContainer: IntervalDIContainerInterface) -> IntervalRouter {
        return IntervalRouter(intervalDIContainer: intervalDIContainer)
    }
}
