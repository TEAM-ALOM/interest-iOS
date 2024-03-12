//
//  WCSessionUseCase.swift
//  Domain
//
//  Created by 김도형 on 1/22/24.
//

import Foundation

import Dependencies

public protocol WCSessionUseCaseInterface {
    func sendMessage(_ message: [String: Any])
    func subscribeReceivedMessage(
        messageHandler: @escaping (_ message: [String: Any]) -> Void)
    func unsubcribeReceivedMessage()
}

public final class WCSessionUseCase: WCSessionUseCaseInterface {
    private let wcSessionRepository: WCSessionRepositoryInterface
    
    public init(wcSessionRepository: WCSessionRepositoryInterface) {
        self.wcSessionRepository = wcSessionRepository
    }
    
    public func sendMessage(_ message: [String : Any]) {
        self.wcSessionRepository.sendMessage(message)
    }
    
    public func subscribeReceivedMessage(messageHandler: @escaping ([String : Any]) -> Void) {
        self.wcSessionRepository.subscribeReceivedMessage(messageHandler: messageHandler)
    }
    
    public func unsubcribeReceivedMessage() {
        self.wcSessionRepository.unsubcribeReceivedMessage()
    }
}
