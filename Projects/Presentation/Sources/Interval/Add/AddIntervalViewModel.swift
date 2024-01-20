//
//  AddIntervalViewModel.swift
//  Presentation
//
//  Created by 민지은 on 2023/11/09.
//

import Foundation
import SwiftUI
import SwiftData

import Domain

@Observable public final class AddIntervalViewModelWithRouter: AddIntervalViewModel {
    private var router: IntervalRouter
    
    public init(
        router: IntervalRouter,
        intervalUseCase: IntervalUseCaseInterface,
        intervalItem: Binding<IntervalModel>?
    ) {
        self.router = router
        super.init(intervalUseCase: intervalUseCase, intervalItem: intervalItem)
    }


    override func tapSaveButton() {
        super.tapSaveButton()
    }

}

@Observable public class AddIntervalViewModel {
    let intervalUseCase: IntervalUseCaseInterface

    public let mode: Mode

    public var intervalItem: Binding<IntervalModel> {
        if let intervalItem = intervalItemOrNil {
            return intervalItem
        } else {
            return .init(get: { self._intervalItem }, set: { self._intervalItem = $0 })
        }
    }

    private var _intervalItem: IntervalModel = .init()
    private var intervalItemOrNil: Binding<IntervalModel>?

    public init(
        intervalUseCase: IntervalUseCaseInterface,
        intervalItem: Binding<IntervalModel>?
    ) {
        self.intervalUseCase = intervalUseCase
        self.intervalItemOrNil = intervalItem

        self.mode = intervalItem == nil ? .add : .edit
    }
    
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
