//
//  WCSessionRepository.swift
//  Data
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import Combine
import Domain

public final class WCSessionRepository: WCSessionRepositoryInterface {
    private let dataSource: WCSessionDataSourceInterface
    
    public init(dataSource: WCSessionDataSourceInterface) {
        self.dataSource = dataSource
    }
    
#if os(iOS)
    public func checkSessionStatus() -> String {
        return dataSource.checkSessionStatus()
    }
    #endif
    
    public func sendMessage(_ message: [String : Any]) {
        dataSource.sendMessage(message)
    }
    
    public func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void) {
        dataSource.observeReceiveMessageValue(key: key, valueHandler: valueHandler)
    }
}
