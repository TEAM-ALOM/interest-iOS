//
//  WCSessionManager.swift
//  InterestApp
//
//  Created by 김도형 on 1/22/24.
//

import Foundation
import WatchConnectivity
import Combine

public class WCSessionManager: NSObject, WCSessionDelegate {
    private let session = WCSession.default
    private var message = PassthroughSubject<[String: Any], Never>()
    private var cancellable = Set<AnyCancellable>()
    
    public override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    #if os(iOS)
    public func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    public func sessionDidDeactivate(_ session: WCSession) {
        
    }
    #endif
    
    public func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        self.message.send(message)
    }
    
    public func subcribeReceivedMessage(messageHandler: @escaping ([String: Any]) -> Void) {
        self.message
            .subscribe(on: DispatchQueue.main)
            .receive(on: DispatchQueue.main)
            .sink { receivedMesssge in
                print(receivedMesssge)
                messageHandler(receivedMesssge)
            }
            .store(in: &cancellable)
    }
    
    public func sendMessage(_ message: [String: Any]) {
//        if session.isReachable {
            session.sendMessage(message, replyHandler: nil, errorHandler: { (error) in
                print("Error sending message: \(error.localizedDescription)")
            })
//        }
    }
    
    #if os(iOS)
    public func checkSessionStatus() -> String {
        if !session.isPaired {
            return "isNotPaired"
        } else if !session.isWatchAppInstalled {
            return "isNotWatchAppInstalled"
        } else if !session.isReachable {
            return "isNotReachable"
        } else {
            return "isConnected"
        }
    }
    #endif
}
