//
//  WCSessionRepositoryInterface.swift
//  Domain
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import Combine

public protocol WCSessionRepositoryInterface {
    func sendMessage(_ message: [String: Any])
    func subscribeReceivedMessage(messageHandler: @escaping (_ message: [String: Any]) -> Void)
    func unsubcribeReceivedMessage()
}
