//
//  EditIntervalViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI
import Domain
import Dependencies

@Observable
public final class EditIntervalViewModelWithRouter: EditIntervalViewModel {
    private var router: IntervalRouter
    private var intervalEntity : Binding<IntervalEntity>
    
    public init(
        router: IntervalRouter,
        intervalEntity : Binding<IntervalEntity>
    ) {
        self.router = router
        self._intervalEntity = intervalEntity
        super.init(intervalItem: intervalEntity)
    }
    
    override func tapSaveButton() {
        super.tapSaveButton()
        
        router.triggerPresentationScreen(presentationRoute: nil)
    }
}

@Observable
public class EditIntervalViewModel{
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
        
    public enum Action {
        case delegate(Delegate)
        
        public enum Delegate {
            case saved(IntervalEntity)
        }
    }
    
    public var send: ((Action.Delegate) -> ())?
    
    public var intervalItem : Binding<IntervalEntity>
    
    public init(
        intervalItem : Binding<IntervalEntity>
    ) {
        _intervalItem = intervalItem

    }

    func tapSaveButton() {
        let entity = intervalItem.wrappedValue
        let result = intervalUseCase.update(at: entity.id, to: entity)
        send?(.saved(entity))
    }
}
