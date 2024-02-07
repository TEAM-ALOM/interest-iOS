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

    override func tapStartButton(intervalItem: IntervalModel) {
        super.tapStartButton(intervalItem: intervalItem)
        let intervalActiveViewModel: IntervalActiveViewModel = IntervalActiveViewModelWithRouter(router: router)
        let intervalActiveRoute: IntervalRouter.NavigationRoute = .intervalActive(intervalActiveViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalActiveRoute)
    }
    
    override func tapIntervalDetailPageButton(intervalItem: IntervalModel) {
        super.tapIntervalDetailPageButton(intervalItem: intervalItem)
        let intervalDetailViewModel: IntervalDetailViewModel = IntervalDetailViewModelWithRouter(router: router)
        let intervalDetailRoute: IntervalRouter.NavigationRoute = .intervalDetail(intervalDetailViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalDetailRoute)
    }

    override func tapIntervalEditButton(selectedItem: Binding<IntervalModel>) {
        super.tapIntervalEditButton(selectedItem: selectedItem)
    }

    func editIntervalScreen(selectedItem: IntervalModel) -> some View {
        return router.nextPresentationScreen()
    }
}


@Observable
public class IntervalListViewModel: Identifiable {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    
    public let id: UUID = .init()
    
    var intervalItems: [IntervalModel] = []
    var selectedItem: IntervalModel? = nil

    public init() { }
    
    func append(interval: IntervalEntity) {
        intervalItems.append(IntervalModelMapper.toPresentationModel(entity: interval))
    }
    
    func fetchIntervalItems() {
        intervalItems = intervalUseCase.fetches().map {
            IntervalModelMapper.toPresentationModel(entity: $0)
        }
    }
    
    func tapStartButton(intervalItem: IntervalModel) { }
    
    func tapIntervalDetailPageButton(intervalItem: IntervalModel) { }
    
    func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
        
        self.fetchIntervalItems()
    }
    
    func tapIntervalEditButton(selectedItem: Binding<IntervalModel>) {
    }
}
