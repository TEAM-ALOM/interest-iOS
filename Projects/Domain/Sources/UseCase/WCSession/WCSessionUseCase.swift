//
//  WCSessionUseCase.swift
//  Domain
//
//  Created by 김도형 on 1/22/24.
//

import Foundation

import Dependencies

public protocol WCSessionUseCaseInterface {
#if os(iOS)
    func checkSessionStatus() -> String
#endif
    func sendMessage(_ message: [String: Any])
    func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void)
    func sendData(_ message: [String: Any])
}

public final class WCSessionUseCase: WCSessionUseCaseInterface {
    private let wcSessionRepository: WCSessionRepositoryInterface
    
    public init(wcSessionRepository: WCSessionRepositoryInterface) {
        self.wcSessionRepository = wcSessionRepository
    }
    
#if os(iOS)
    public func checkSessionStatus() -> String {
        return wcSessionRepository.checkSessionStatus()
    }
#endif
    
    public func sendMessage(_ message: [String : Any]) {
        wcSessionRepository.sendMessage(message)
    }
    
    public func sendData(_ message: [String : Any]) {
        wcSessionRepository.sendData(message)
    }
    
    public func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void) {
        wcSessionRepository.observeReceiveMessageValue(key: key, valueHandler: valueHandler)
    }
}



//extension WCSessionUseCase {
//    public static func live(
//        wcSessionRepository: WCSessionRepositoryInterface
//    ) -> Self {
//        return Self(wcSessionRepository: wcSessionRepository)
//    }
//}
