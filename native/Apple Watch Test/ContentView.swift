//
//  ContentView.swift
//  Apple Watch Test
//
//  Created by Rexios on 1/31/23.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @ObservedObject var controller = Controller()
    
    var body: some View {
        Text("\(controller.count)")
    }
}

class Controller: NSObject, ObservableObject, WCSessionDelegate {
    @Published var count = 0
    
    override init() {
        super.init()
        WCSession.default.delegate = self
        WCSession.default.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        count = message["count"] as! Int
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
    func sessionDidBecomeInactive(_ session: WCSession) {}
    func sessionDidDeactivate(_ session: WCSession) {}
}
