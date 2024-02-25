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
    func observeReceiveData<T: Codable>(key: String, dataHandler: @escaping (T) -> Void)
    func sendData(key: String, value: Codable)
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
    
    public func sendData(key: String, value: Codable) {
        wcSessionRepository.sendData(key: key, value: value)
    }
    
    public func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void) {
        wcSessionRepository.observeReceiveMessageValue(key: key, valueHandler: valueHandler)
    }
    
    public func observeReceiveData<T>(key: String, dataHandler: @escaping (T) -> Void) where T : Decodable, T : Encodable {
        wcSessionRepository.observeReceiveData(key: key, dataHandler: dataHandler)
    }
}



//extension WCSessionUseCase {
//    public static func live(
//        wcSessionRepository: WCSessionRepositoryInterface
//    ) -> Self {
//        return Self(wcSessionRepository: wcSessionRepository)
//    }
//}
