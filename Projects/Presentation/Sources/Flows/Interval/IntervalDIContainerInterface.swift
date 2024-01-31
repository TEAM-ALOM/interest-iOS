//
//  IntervalDIContainerInterface.swift
//  Presentation
//
//  Created by 송영모 on 11/13/23.
//

import Foundation
import SwiftUI

public protocol IntervalDIContainerInterface {
    func intervalScreenDependencies(intervalRouter: IntervalRouter) -> IntervalViewModel
    func intervalListDependencies(intervalRouter: IntervalRouter) -> IntervalListViewModel
    func intervalActiveDependencies(intervalRouter: IntervalRouter, intervalItem: IntervalModel) -> IntervalActiveViewModel
    func addIntervalDependencies(intervalRouter: IntervalRouter, intervalItem: Binding<IntervalModel>?) -> AddIntervalViewModel
    func intervalDetailDependencies(intervalRouter: IntervalRouter, intervalItem: IntervalModel) -> IntervalDetailViewModel
}
