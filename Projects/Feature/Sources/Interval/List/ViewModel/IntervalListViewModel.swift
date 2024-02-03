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
public class IntervalListViewModel: Identifiable {
    @ObservationIgnored @Dependency(\.intervalUseCase) var intervalUseCase
    
    public let id: UUID = .init()
    
    var intervalItems: [IntervalModel] = []
    var selectedItem: IntervalModel? = nil

    public init() { }
    
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
