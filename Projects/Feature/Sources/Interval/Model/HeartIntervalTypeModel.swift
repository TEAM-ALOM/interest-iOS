//
//  HeartIntervalTypeModel.swift
//  Presentation
//
//  Created by 김도형 on 12/30/23.
//

import Foundation

public enum HeartIntervalTypeModel : String, CaseIterable, Identifiable{
    case one = "1구간"
    case two = "2구간"
    case three = "3구간"
    case four = "4구간"
    case five = "5구간"
    
    public var id: Self { self }

}
