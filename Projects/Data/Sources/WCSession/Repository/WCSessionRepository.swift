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
