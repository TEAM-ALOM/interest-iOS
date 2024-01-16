//
//  IntervalDIContainerInterface.swift
//  Presentation
//
//  Created by 송영모 on 11/13/23.
//

import Foundation

public protocol IntervalDIContainerInterface {
    func intervalScreenDependencies(intervalRouter: IntervalRouter) -> IntervalViewModel
    func intervalListDependencies(intervalRouter: IntervalRouter) -> IntervalListViewModelWithRouter
    func intervalActiveDependencies(intervalRouter: IntervalRouter) -> IntervalActiveViewModelWithRouter
    func addIntervalDependencies(intervalRouter: IntervalRouter) -> AddIntervalViewModelWithRouter
    func addIntervalDependencies(intervalRouter: IntervalRouter, intervalItem: IntervalModel) -> AddIntervalViewModelWithRouter
    func intervalDetailDependencies(intervalRouter: IntervalRouter, intervalItem: IntervalModel) -> IntervalDetailViewModelWithRouter
}
