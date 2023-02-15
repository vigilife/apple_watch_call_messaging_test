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

    func session(_: WCSession, didReceiveMessage message: [String: Any]) {
        DispatchQueue.main.async { self.count = message["count"] as! Int }
    }

    func session(_: WCSession, activationDidCompleteWith _: WCSessionActivationState, error _: Error?) {}
    func sessionDidBecomeInactive(_: WCSession) {}
    func sessionDidDeactivate(_: WCSession) {}
}
