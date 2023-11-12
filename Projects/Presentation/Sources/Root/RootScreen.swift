//
//  RootScreen.swift
//  Presentation
//
//  Created by 송영모 on 11/3/23.
//

import SwiftUI

public struct RootScreen: View {
    public init() { }
    
    public var body: some View {
        IntervalScreen(router: .init())
    }
}
