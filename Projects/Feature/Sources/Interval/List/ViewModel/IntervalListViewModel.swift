//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Dependencies
import Perception

import Domain

@Observable
public final class IntervalListViewModelWithRouter: IntervalListViewModel {
    private var router: IntervalRouter

    public init(
        router: IntervalRouter
    ) {
        self.router = router
        super.init()
    }

    public override func tapStartButton(intervalItem: IntervalEntity) {
        super.tapStartButton(intervalItem: intervalItem)
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: router)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
    
    public override func tapIntervalDetailPageButton(intervalItem: IntervalEntity) {
        super.tapIntervalDetailPageButton(intervalItem: intervalItem)
        let intervalDetailViewModel: IntervalDetailViewModel = IntervalDetailViewModelWithRouter(router: router, intervalEntity: intervalItem)
        let intervalDetailRoute: IntervalRouter.NavigationRoute = .intervalDetail(intervalDetailViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalDetailRoute)
    }

    public override func tapIntervalEditButton(selectedItem: Binding<IntervalEntity>) {
        super.tapIntervalEditButton(selectedItem: selectedItem)
        let editIntervalViewModel : EditIntervalViewModel = EditIntervalViewModelWithRouter(router: router, intervalEntity: selectedItem.wrappedValue)
        let editIntervalRoute : IntervalRouter.PresentationRoute = .editInterval(editIntervalViewModel)
        
        editIntervalViewModel.send =  { [weak self] delegate in
            guard let `self` = self else { return }
            switch delegate {
            case let .fetched(entity):
                selectedItem.wrappedValue = entity
                print(selectedItem.wrappedValue.title)
                self.fetchIntervalItems()
                print("-------------")
            }
        }
        router.triggerPresentationScreen(presentationRoute: editIntervalRoute)
    }

    func editIntervalScreen(selectedItem: IntervalEntity) -> some View {
        return router.nextPresentationScreen()
    }
}


@Observable
public class IntervalListViewModel: IntervalListViewModelInterface, Identifiable {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    
    public let id: UUID = .init()
    
    var intervalItems: [IntervalEntity] = []
    
    public init() {
    }

    public func append(interval: IntervalEntity) {
        intervalItems.append(interval)
    }
    
    public func fetchIntervalItems() {
        intervalItems = intervalUseCase.fetches().map { intervalEntity in
            return intervalEntity
        }
    }
    
    public func tapStartButton(intervalItem: IntervalEntity) { }
    
    public func tapIntervalDetailPageButton(intervalItem: IntervalEntity) { }
    
    public func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
        
        self.fetchIntervalItems()
    }
    
    public func tapIntervalEditButton(selectedItem: Binding<IntervalEntity>) {
    }

}
