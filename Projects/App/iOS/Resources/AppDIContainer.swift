//
//  AppDIContainer.swift
//  InterestApp
//
//  Created by 송영모 on 11/13/23.
//

import Foundation

import Presentation
import Domain
import Data

public protocol IntervalDIContainerInterface {
    func intervalScreenDependencies() -> IntervalViewModel
    func intervalListDependencies() -> IntervalListViewModel
}

public final class IntervalDIContainer: IntervalDIContainerInterface {
    public func intervalScreenDependencies() -> IntervalViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        
        return .init(router: .init(), intervalUseCase: intervalUseCase)
    }
    
    public func intervalListDependencies() -> IntervalListViewModel {
        let intervalDataSource = IntervalDataSource()
        let intervalRepository = IntervalRepository(dataSource: intervalDataSource)
        let intervalUseCase = IntervalUseCase(intervalRepository: intervalRepository)
        return .init(intervalUseCase: intervalUseCase)
    }
}
