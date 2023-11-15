//
//  IntervalDIContainerInterface.swift
//  Presentation
//
//  Created by 송영모 on 11/13/23.
//

import Foundation

public protocol IntervalDIContainerInterface {
    func intervalRouter() -> IntervalRouter
    func intervalScreenDependencies(intervalRouter: IntervalRouter) -> IntervalViewModel
    func intervalListDependencies(intervalRouter: IntervalRouter) -> IntervalListViewModel
    func addIntervalDependencies(intervalRouter: IntervalRouter) -> AddIntervalViewModel
    func intervalDetailDependencies(intervalRouter: IntervalRouter) -> IntervalDetailViewModel
}
