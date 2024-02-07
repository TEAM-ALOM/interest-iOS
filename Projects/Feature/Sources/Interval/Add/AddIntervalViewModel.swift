//
//  AddIntervalViewModel.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI
import SwiftData

import Dependencies

import Domain

@Observable 
public final class AddIntervalViewModelWithRouter: AddIntervalViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter
    ) {
        self.router = router
        super.init()
    }
    
    func actionMutation(action: Action) {
        switch action {
        case .inner(.saveButtonTapped):
            router.triggerPresentationScreen(presentationRoute: nil)
        default: break
        }
    }
}

@Observable
public class AddIntervalViewModel {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    public enum Action {
        case inner(InnerAction)
        case outer(OuterAction)
        case delegate(DelegateAction)
    }
    
    public enum InnerAction {
        case onAppear
        case saveButtonTapped
        case titleChanged(String)
    }
    
    public enum OuterAction { }
    
    public enum DelegateAction {
        case saved(IntervalEntity)
    }
    
    public var actionHandler: ((Action) -> ())?
    public var innerActionHandler: (InnerAction) -> ()
    public var delegateActionHandler: ((DelegateAction) -> ())?
    
    public var interval: IntervalEntity = .init(id: .init())
    
    public init() {
        self.innerActionHandler = { self.innerActionMutation(action: $0) }
    }
    
    public func send(action: InnerAction) {
        self.innerActionHandler(action)
        self.actionHandler?(.inner(action))
    }
    
    public func send(action: DelegateAction) {
        self.delegateActionHandler?(action)
        self.actionHandler?(.delegate(action))
    }
    
    private func innerActionMutation(action: InnerAction) {
        self.innerActionHandler = { [weak self] action in
            guard let `self` = self else { return }
            switch action {
            case .onAppear:
                break
            case .saveButtonTapped:
                intervalUseCase.save(interval: interval)
                send(action: .saved(interval))
                break
            case let .titleChanged(title):
                interval.title = title
                break
            }
        }
    }
}
