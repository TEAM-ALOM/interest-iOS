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

    public init(intervalUseCase: IntervalUseCaseInterface) {
        self.intervalUseCase = intervalUseCase
        //self.selectedItem = selectedItem
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
//        self.selectedItem = selectedItem
    }
}
