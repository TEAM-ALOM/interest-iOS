//
//  WCSessionDataSource.swift
//  Data
//
//  Created by 김도형 on 1/22/24.
//

import Foundation

import Dependencies

public protocol WCSessionDataSourceInterface {
#if os(iOS)
    func checkSessionStatus() -> String
#endif
    func sendMessage(_ message: [String: Any])
    func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void)
    func sendData(_ message: [String: Any])
}

public final class WCSessionDataSource: WCSessionDataSourceInterface {
    private let manager: WCSessionManager
    
    public init(manager: WCSessionManager) {
        self.manager = manager
    }
    
#if os(iOS)
    public func checkSessionStatus() -> String {
        return manager.checkSessionStatus().rawValue
    }
#endif
    
    public func sendMessage(_ message: [String: Any]) {
        manager.sendMessage(message)
    }
    
    public func sendData(_ message: [String: Any]) {
        manager.sendData(message)
    }
    
    public func observeReceiveMessageValue<T>(key: String, 
                                       valueHandler: @escaping (T) -> Void) {
        manager.subcribeReceivedMessage { message in
            guard let value = message[key] as? T else {
                print(message[key])
                return
            }
            
            valueHandler(value)
        }
    }
}
