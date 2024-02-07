//
//  IntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

import Dependencies

import Domain

@Observable 
public final class IntervalViewModel {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    
    private let router: IntervalRouter
    
    public var intervalListViewModel: IntervalListViewModel
    
    public var isBottomSheetPresent = false
    
    public init(
        router: IntervalRouter
    ) {
        self.router = router
        self.intervalListViewModel = IntervalListViewModelWithRouter(router: router)
    }
    
    public func send() {
        
    }

    public func tapPlusButton() {
        let addIntervalViewModel: AddIntervalViewModel = AddIntervalViewModelWithRouter(router: router)
        let addIntervalRoute: IntervalRouter.PresentationRoute = .addInterval(addIntervalViewModel)
        
        addIntervalViewModel.delegateActionHandler =  { [weak self] delegate in
            guard let `self` = self else { return }
            switch delegate {
            case let .saved(entity):
                self.intervalListViewModel.append(interval: entity)
            }
            
        }
        router.triggerPresentationScreen(presentationRoute: addIntervalRoute)
    }

    public func tapIntervalStartButton(intervalItem: IntervalModel) {
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: router)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
}
