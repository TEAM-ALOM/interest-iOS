//
//  WCSessionDataSource.swift
//  Data
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import Dependencies
import Domain

public protocol WCSessionDataSourceInterface {
    func sendMessage(_ message: [String: Any])
    func subscribeReceivedMessage(messageHandler: @escaping (_ message: [String: Any]) -> Void)
    func unsubcribeReceivedMessage()
}

public final class WCSessionDataSource: WCSessionDataSourceInterface {
    private let manager: WCSessionManager
    
    public init(manager: WCSessionManager) {
        self.manager = manager
    }
    
    public func sendMessage(_ message: [String: Any]) {
        if let value = message["ACTIVE_INTERVAL"] as? ActiveIntervalEntity,
            let data = try? JSONEncoder().encode(value),
            let json = String(data: data, encoding: .utf8) {
            manager.sendMessage(["ACTIVE_INTERVAL": json])
        } else {
            manager.sendMessage(message)
        }
    }
    
    public func subscribeReceivedMessage(messageHandler: @escaping (_ message: [String: Any]) -> Void) {
        manager.subscribeReceivedMessage { message in
            if let value = message["ACTIVE_INTERVAL"] as? String,
                let data = value.data(using: .utf8),
                let interval = try? JSONDecoder().decode(ActiveIntervalEntity.self, from: data) {
                messageHandler(["ACTIVE_INTERVAL": interval])
            } else {
                messageHandler(message)
            }
        }
    }
    
    public func unsubcribeReceivedMessage() {
        self.manager.unsubcribeReceivedMessage()
    }
}

extension WCSessionDataSource: TestDependencyKey {
    public static var testValue: WCSessionDataSource = unimplemented()
}

public extension DependencyValues {
    var wcSessionDataSource: WCSessionDataSource {
        get { self[WCSessionDataSource.self] }
        set { self[WCSessionDataSource.self] = newValue }
    }
}

extension WCSessionDataSource: DependencyKey {
    public static var liveValue: WCSessionDataSource = .init(manager: .init())
}
