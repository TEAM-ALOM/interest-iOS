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

    override func tapStartButton(intervalItem: IntervalEntity) {
        super.tapStartButton(intervalItem: intervalItem)
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: router)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
    
    override func tapIntervalDetailPageButton(intervalItem: IntervalEntity) {
        super.tapIntervalDetailPageButton(intervalItem: intervalItem)
        let intervalDetailViewModel: IntervalDetailViewModel = IntervalDetailViewModelWithRouter(router: router)
        let intervalDetailRoute: IntervalRouter.NavigationRoute = .intervalDetail(intervalDetailViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalDetailRoute)
    }

    override func tapIntervalEditButton(selectedItem: Binding<IntervalEntity>) {
        super.tapIntervalEditButton(selectedItem: selectedItem)
        let editIntervalViewModel : EditIntervalViewModel = EditIntervalViewModelWithRouter(router: router, intervalEntity: selectedItem.wrappedValue)
        let editIntervalRoute : IntervalRouter.PresentationRoute = .editInterval(editIntervalViewModel)
        
        router.triggerPresentationScreen(presentationRoute: editIntervalRoute)
    }

    func editIntervalScreen(selectedItem: IntervalEntity) -> some View {
        return router.nextPresentationScreen()
    }
}


@Observable
public class IntervalListViewModel: Identifiable {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    
    public let id: UUID = .init()
    
    var intervalItems: [IntervalEntity] = []
    var selectedItem: IntervalEntity? = nil

    public init() { }
    
    func append(interval: IntervalEntity) {
        intervalItems.append(interval)
    }
    
    func fetchIntervalItems() {
        intervalItems = intervalUseCase.fetches().map { intervalEntity in
            return intervalEntity
        }
    }
    
    func tapStartButton(intervalItem: IntervalEntity) { }
    
    func tapIntervalDetailPageButton(intervalItem: IntervalEntity) { }
    
    func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
        
        self.fetchIntervalItems()
    }
    
    func tapIntervalEditButton(selectedItem: Binding<IntervalEntity>) {
        let _ = intervalUseCase.update(at: selectedItem.wrappedValue.id, to: selectedItem.wrappedValue)
        
        self.fetchIntervalItems()
    }

}
