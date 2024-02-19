//
//  IntervalListViewModelInterface.swift
//  Domain
//
//  Created by 최유경 on 2/19/24.
//

import Foundation
import SwiftUI

public protocol IntervalListViewModelInterface {
    func append(interval: IntervalEntity)
    func fetchIntervalItems()
    func tapStartButton(intervalItem: IntervalEntity)
    func tapIntervalDetailPageButton(intervalItem: IntervalEntity)
    func tapIntervalDeleteButton(at id: UUID)
    func tapIntervalEditButton(selectedItem: Binding<IntervalEntity>)
}
