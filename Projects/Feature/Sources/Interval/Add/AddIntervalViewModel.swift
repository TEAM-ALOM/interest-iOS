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
    public let mode: Mode
    
    public init() {
        self.mode = .add
    }

    public var intervalItem: Binding<IntervalModel> {
        if let intervalItem = intervalItemOrNil {
            return intervalItem
        } else {
            return .init(get: { self._intervalItem }, set: { self._intervalItem = $0 })
        }
    }

    private var _intervalItem: IntervalModel = .init()
    private var intervalItemOrNil: Binding<IntervalModel>?

    
    func tapSaveButton() {
        let entity = IntervalModelMapper.toEntity(model: intervalItem.wrappedValue)

        switch self.mode {
        case .add:
            intervalUseCase.save(interval: entity)
        case .edit:
            intervalUseCase.update(at: entity.id, to: entity)
        }
    }
}

extension AddIntervalViewModel {
    public enum Mode {
        case add
        case edit
    }
}
