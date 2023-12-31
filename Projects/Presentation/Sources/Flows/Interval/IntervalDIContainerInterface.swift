//
//  IntervalDIContainerInterface.swift
//  Presentation
//
//  Created by 송영모 on 11/13/23.
//

import Foundation

public protocol IntervalDIContainerInterface {
    func intervalScreenDependencies(intervalRouter: IntervalRouter) -> IntervalViewModel
    func intervalListDependencies(intervalRouter: IntervalRouter) -> IntervalListViewModel
    func intervalActiveDependencies(intervalRouter: IntervalRouter) -> IntervalActiveViewModel
    func addIntervalDependencies(intervalRouter: IntervalRouter) -> AddIntervalViewModel
    func intervalDetailDependencies(intervalRouter: IntervalRouter, intervalID: UUID) -> IntervalDetailViewModel
}
