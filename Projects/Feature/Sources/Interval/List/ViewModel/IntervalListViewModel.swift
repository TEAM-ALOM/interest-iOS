//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Presentation
import Domain

import SharedThirdPartyLib
import Dependencies
import Perception

@Observable
public final class IntervalListViewModelWithRouter: IntervalListViewModel {
    private var router: IntervalRouter

    public init(
        router: IntervalRouter
    ) {
        self.router = router
        super.init()
    }
    
    override public func tapIntervalDetailPageButton(interval: IntervalEntity) {
        super.tapIntervalDetailPageButton(interval: interval)
        let intervalDetailViewModel: IntervalDetailViewModel = IntervalDetailViewModelWithRouter(router: router, interval: interval)
        let intervalDetailRoute: IntervalRouter.NavigationRoute = .intervalDetail(intervalDetailViewModel)
        
        router.triggerNavigationScreen(navigationRoute: intervalDetailRoute)
    }

    public override func tapIntervalEditButton(selectedInterval: Binding<IntervalEntity>) {
        super.tapIntervalEditButton(selectedInterval: selectedInterval)
        let editIntervalViewModel : EditIntervalViewModel = EditIntervalViewModelWithRouter(router: router, interval: selectedInterval.wrappedValue)
        let editIntervalRoute : IntervalRouter.PresentationRoute = .editInterval(editIntervalViewModel)
        
        editIntervalViewModel.send =  { [weak self] delegate in
            guard let `self` = self else { return }
            switch delegate {
            case let .fetched(entity):
                selectedInterval.wrappedValue = entity
                self.fetchIntervalItems()
            }
        }
        router.triggerPresentationScreen(presentationRoute: editIntervalRoute)
    }

    func editIntervalScreen(selectedInterval: IntervalEntity) -> some View {
        return router.nextPresentationScreen()
    }
}


@Observable
public class IntervalListViewModel: IntervalListViewModelInterface, Identifiable {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    @ObservationIgnored @Dependency(\.workoutUseCase) var workoutUseCase
    @ObservationIgnored @Dependency(\.wcSessionUseCase) var wcSessionUseCase
    
    public let id: UUID = .init()
    
    var intervals: [IntervalEntity] = []
    var selectedInterval: IntervalEntity? = .init(id: UUID(uuidString: "1F8EFB31-50D6-470A-997E-716E83BF26D6")!)

    public init() { }
    
    public func append(interval: IntervalEntity) {
        intervals.append(interval)
    }
    
    public func fetchIntervalItems() {
        intervals = intervalUseCase.fetches()
    }
    
    public func tapStartButton(interval: IntervalEntity) {
        workoutUseCase.startWorkout(interval: interval)
        wcSessionUseCase.sendMessage(["INTERVAL_ID": interval.id.uuidString])
    }
    
    public func observeIntervalMessage() {
        wcSessionUseCase.observeReceiveData(key: "INTERVAL_SAVE") { [weak self] (interval: IntervalEntity) in
            guard let `self` = self else { return }
            self.intervalUseCase.save(interval: interval)
            withAnimation(.snappy) {
                self.fetchIntervalItems()
            }
        }
        
        wcSessionUseCase.observeReceiveData(key: "INTERVAL_UPDATE") { [weak self] (interval: IntervalEntity) in
            guard let `self` = self else { return }
            let _ = self.intervalUseCase.update(at: interval.id, to: interval)
            withAnimation(.snappy) {
                self.fetchIntervalItems()
            }
        }
        
        wcSessionUseCase.observeReceiveData(key: "INTERVAL_DELETE") { [weak self] (id: UUID) in
            guard let `self` = self else { return }
            let _ = self.intervalUseCase.delete(at: id)
            withAnimation(.snappy) {
                self.fetchIntervalItems()
            }
        }
    }
    
    public func tapIntervalDetailPageButton(interval: IntervalEntity) { }
    
    public func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
        self.wcSessionUseCase.sendData(key: "INTERVAL_DELETE", value: id)
        
        withAnimation(.snappy) {
            self.fetchIntervalItems()
        }
    }
    
    public func tapIntervalEditButton(selectedInterval: Binding<IntervalEntity>) {
        
    }
    
    public func checkSessionState() {
//        let status = wcSessionUseCase.checkSessionStatus()
//        print(status)
    }
}
