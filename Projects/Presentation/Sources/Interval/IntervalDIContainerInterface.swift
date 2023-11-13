//
//  IntervalDIContainerInterface.swift
//  Presentation
//
//  Created by 송영모 on 11/13/23.
//

import Foundation

public protocol IntervalDIContainerInterface {
    var intervalRouter: IntervalRouter { get set }
    
    func intervalScreenDependencies() -> IntervalViewModel
    func intervalListDependencies() -> IntervalListViewModel
}
