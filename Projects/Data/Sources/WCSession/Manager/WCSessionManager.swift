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
    private(set) var message = PassthroughSubject<[String: Any], Never>()
    private var messageCacellable = Set<AnyCancellable>()
    
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
    
    func subscribeReceivedMessage(messageHandler: @escaping (_ message: [String: Any]) -> Void) {
            self.message
                .subscribe(on: DispatchQueue.main)
                .receive(on: DispatchQueue.main)
                .sink { message in
                    messageHandler(message)
                }
                .store(in: &messageCacellable)
        }
    
    func unsubcribeReceivedMessage() {
        self.messageCacellable.removeAll()
    }
    
    func sendMessage(_ message: [String: Any]) {
        session.sendMessage(message, replyHandler: nil, errorHandler: { (error) in
            print("Error sending message: \(error.localizedDescription)")
        })
    }
}
