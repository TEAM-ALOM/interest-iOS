//
//  WCSessionRepository.swift
//  Data
//
//  Created by 김도형 on 1/22/24.
//

import Foundation

import Dependencies

import Domain

public final class WCSessionRepository: WCSessionRepositoryInterface {
    private let dataSource: WCSessionDataSourceInterface
    
    public init(dataSource: WCSessionDataSourceInterface) {
        self.dataSource = dataSource
    }
    
    public func sendMessage(_ message: [String : Any]) {
        self.dataSource.sendMessage(message)
    }
    
    public func subscribeReceivedMessage(messageHandler: @escaping ([String : Any]) -> Void) {
        self.dataSource.subscribeReceivedMessage(messageHandler: messageHandler)
    }
    
    public func unsubcribeReceivedMessage() {
        self.dataSource.unsubcribeReceivedMessage()
    }
}

extension WCSessionRepository: TestDependencyKey {
    public static var testValue: WCSessionRepository = unimplemented()
}

public extension DependencyValues {
    var wcSessionRepository: WCSessionRepository {
        get { self[WCSessionRepository.self] }
        set { self[WCSessionRepository.self] = newValue }
    }
}

extension WCSessionRepository: DependencyKey {
    public static var liveValue: WCSessionRepository = .init(dataSource: DependencyValues.live.wcSessionDataSource)
}
