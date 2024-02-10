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
    
    
    override func tapSaveButton() {
        super.tapSaveButton()
        
        router.triggerPresentationScreen(presentationRoute: nil)
    }
}

@Observable
public class AddIntervalViewModel {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    
    public enum Action {
        case delegate(Delegate)
        
        public enum Delegate {
            case saved(IntervalEntity)
        }
    }
    
    public var send: ((Action.Delegate) -> ())?
    
    public init() {
        self._intervalItem = .init(id: UUID())
    }
    
    public var intervalItem: Binding<IntervalEntity> {
        if let intervalItem = intervalItemOrNil {
            return intervalItem
        } else {
            return .init(get: { self._intervalItem }, set: { self._intervalItem = $0 })
        }
    }
    
    public var _intervalItem : IntervalEntity
    
    private var intervalItemOrNil: Binding<IntervalEntity>?
    
    
    func tapSaveButton() {
        let entity = intervalItem.wrappedValue
        let interval = intervalUseCase.save(interval: entity)
        send?(.saved(entity))
    }
}
