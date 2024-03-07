//
//  ActiveIntervalEntity.swift
//  Domain
//
//  Created by 김도형 on 2/25/24.
//

import Foundation

public struct ActiveIntervalEntity: Codable {
    public var currentIntervalType: ActiveIntervalType = .resting
    public var currentIntervalCount: Int = 0
    public var restingCount: Int = 1
    public var burningCount: Int = 0
    
    public init() { }
}

extension ActiveIntervalEntity {
    public enum ActiveIntervalType: Codable {
        case burning
        case resting
        
        public var systemImage: String {
            switch self {
            case .burning:
                return "flame.fill"
            case .resting:
                return "circle.hexagonpath.fill"
            }
        }
        
        public var text: String {
            switch self {
            case .burning:
                return "버닝"
            case .resting:
                return "휴식"
            }
        }
    }
}
