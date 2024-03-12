//
//  IntervalListViewModelInterface.swift
//  Domain
//
//  Created by 최유경 on 2/19/24.
//

import Foundation
import Domain
import SwiftUI

public protocol IntervalListViewModelInterface {
    func append(interval: IntervalEntity)
    func fetchIntervalItems()
#if os(watchOS)
    func tapStartButton(interval: IntervalEntity)
#endif
    func tapIntervalDetailPageButton(interval: IntervalEntity)
    func tapIntervalDeleteButton(at id: UUID)
    func tapIntervalEditButton(selectedInterval: Binding<IntervalEntity>)
}
