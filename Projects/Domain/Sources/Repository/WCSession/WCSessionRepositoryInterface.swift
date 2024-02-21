//
//  WCSessionRepositoryInterface.swift
//  Domain
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import Combine

public protocol WCSessionRepositoryInterface {
#if os(iOS)
    func checkSessionStatus() -> String
#endif
    func sendMessage(_ message: [String: Any])
    func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void)
    func sendData(_ message: [String: Any])
}
