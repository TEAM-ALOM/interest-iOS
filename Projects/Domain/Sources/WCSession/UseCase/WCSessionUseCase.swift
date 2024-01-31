//
//  WCSessionUseCase.swift
//  Domain
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import Combine

public protocol WCSessionUseCaseInterface {
#if os(iOS)
    func checkSessionStatus() -> String
#endif
    func sendMessage(_ message: [String: Any])
    func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void)
}

public final class WCSessionUseCase: WCSessionUseCaseInterface {
    private let repository: WCSessionRepositoryInterface
    
    public init(repository: WCSessionRepositoryInterface) {
        self.repository = repository
    }
    
#if os(iOS)
    public func checkSessionStatus() -> String {
        return repository.checkSessionStatus()
    }
#endif
    
    public func sendMessage(_ message: [String : Any]) {
        repository.sendMessage(message)
    }
    
    public func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void) {
        repository.observeReceiveMessageValue(key: key, valueHandler: valueHandler)
    }
}
