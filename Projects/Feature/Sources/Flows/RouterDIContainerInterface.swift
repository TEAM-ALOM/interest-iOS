//
//  RouterDIContainerInterface.swift
//  Presentation
//
//  Created by 김도형 on 12/4/23.
//

import Foundation

public protocol RouterDIContainerInterface {
    func intervalRouter(intervalDIContainer: IntervalDIContainerInterface) -> IntervalRouter
}
