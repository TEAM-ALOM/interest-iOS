//
//  LinearGradient+Extension.swift
//  SharedDesignSystem
//
//  Created by 김도형 on 12/30/23.
//

import Foundation
import SwiftUI

extension LinearGradient {
    static let darkBackground = LinearGradient(
        stops: [
            Gradient.Stop(
                color: Color(red: 0.4, green: 0.33, blue: 1).opacity(0.2),
                location: 0.00
            ),
            Gradient.Stop(
                color: Color(red: 0.2, green: 0.53, blue: 1).opacity(0.1),
                location: 0.52
            ),
            Gradient.Stop(
                color: Color(red: 0.4, green: 0.33, blue: 1).opacity(0),
                location: 1.00
            ),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
    
    static let lightBackground = LinearGradient(
        stops: [
            Gradient.Stop(
                color: Color(red: 0.4, green: 0.33, blue: 1).opacity(0.25),
                location: 0.00
            ),
            Gradient.Stop(
                color: Color(red: 0, green: 0.41, blue: 1).opacity(0.15),
                location: 0.52
            ),
            Gradient.Stop(
                color: Color(red: 0.52, green: 0.47, blue: 1).opacity(0),
                location: 1.00
            ),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
    
    static let burningBackground = LinearGradient(
        stops: [
            Gradient.Stop(
                color: Color(red: 1, green: 0.13, blue: 0.02).opacity(0.2),
                location: 0.00
            ),
            Gradient.Stop(
                color: Color(red: 1, green: 0.13, blue: 0.02).opacity(0),
                location: 1.00
            ),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
    
    static let restBackground = LinearGradient(
        stops: [
            Gradient.Stop(
                color: Color(red: 0.09, green: 1, blue: 0.02).opacity(0.2),
                location: 0.00
            ),
            Gradient.Stop(
                color: Color(red: 0.09, green: 1, blue: 0.02).opacity(0),
                location: 1.00
            ),
        ],
        startPoint: UnitPoint(x: 0.5, y: 0),
        endPoint: UnitPoint(x: 0.5, y: 1)
    )
}
