//
//  IntervalListViewModel.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import Foundation
import SwiftUI

import Domain

@Observable public class IntervalListViewModel {
    private let intervalUseCase: IntervalUseCaseInterface
    
    var intervalItems: [IntervalModel] = []
    var selectedItem: IntervalModel? = nil

    var isShowEditIntervalView: Bool = false

    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
    }
    
    func fetchIntervalItems() {
        intervalItems = intervalUseCase.fetches().map {
            IntervalModelMapper.toPresentationModel(entity: $0)
        }
    }
    
    func tapStartButton() { }
    
    func tapIntervalDetailPageButton(intervalItem: IntervalModel) { }
    
    func tapIntervalDeleteButton(at id: UUID) {
        let _ = intervalUseCase.delete(at: id)
        
        self.fetchIntervalItems()
    }
    
    func tapIntervalEditButton(selectedItem: IntervalModel) {
        isShowEditIntervalView = true
        self.selectedItem = selectedItem
    }
}
