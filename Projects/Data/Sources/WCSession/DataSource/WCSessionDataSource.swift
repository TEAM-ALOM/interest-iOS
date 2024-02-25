//
//  WCSessionDataSource.swift
//  Data
//
//  Created by 김도형 on 1/22/24.
//

import Foundation

import Dependencies

public protocol WCSessionDataSourceInterface {
#if os(iOS)
    func checkSessionStatus() -> String
#endif
    func sendMessage(_ message: [String: Any])
    func observeReceiveMessageValue<T>(key: String, valueHandler: @escaping (T) -> Void)
    func observeReceiveData<T: Codable>(key: String, dataHandler: @escaping (T) -> Void)
    func sendData(key: String, value: Codable)
}

public final class WCSessionDataSource: WCSessionDataSourceInterface {
    private let manager: WCSessionManager
    
    public init(manager: WCSessionManager) {
        self.manager = manager
    }
    
#if os(iOS)
    public func checkSessionStatus() -> String {
        return manager.checkSessionStatus().rawValue
    }
#endif
    
    public func sendMessage(_ message: [String: Any]) {
        manager.sendMessage(message)
    }
    
    public func sendData(key: String, value: Codable) {
        guard let jsonData = try? JSONEncoder().encode(value) else {
            print("encode error")
            return
        }
        
        guard let data = String(data: jsonData, encoding: .utf8) else {
            print("error")
            return
        }
        manager.sendData([key: data])
    }
    
    public func observeReceiveData<T: Codable>(key: String, dataHandler: @escaping (T) -> Void) {
        manager.subcribeReceivedMessage { message in
            guard let value = message[key] as? String else {
                print("no value")
                return
            }
            
            guard let jsonData = value.data(using: .utf8) else {
                print("no json")
                return
            }
            
            guard let data = try? JSONDecoder().decode(T.self, from: jsonData) else {
                print("decode error")
                return
            }
            
            dataHandler(data)
        }
    }
    
    public func observeReceiveMessageValue<T>(key: String, 
                                       valueHandler: @escaping (T) -> Void) {
        manager.subcribeReceivedMessage { message in
            guard let value = message[key] as? T else {
                print(message[key])
                return
            }
            valueHandler(value)
        }
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
    public static var liveValue: WCSessionDataSource = .init(manager: .shared)
}
