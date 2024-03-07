//
//  WCSessionDataSource.swift
//  Data
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import Dependencies

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
        manager.sendMessage(message)
    }
    
    public func subscribeReceivedMessage(messageHandler: @escaping (_ message: [String: Any]) -> Void) {
        manager.subscribeReceivedMessage(messageHandler: messageHandler)
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
