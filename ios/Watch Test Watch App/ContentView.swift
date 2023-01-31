//
//  ContentView.swift
//  Watch Test Watch App
//
//  Created by Rexios on 1/31/23.
//

import HealthKit
import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @ObservedObject var controller = Controller()

    var body: some View {
        Button(action: controller.toggle) {
            Text(controller.started ? "Stop" : "Start")
        }
    }
}

class Controller: NSObject, ObservableObject, WCSessionDelegate {
    @Published var started = false
    var session: HKWorkoutSession?
    var count = 0

    override init() {
        super.init()
        WCSession.default.activate()
        WCSession.default.delegate = self
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: send)
    }

    func send(timer: Timer) {
        WCSession.default.sendMessage(["message": count += 1], replyHandler: nil)
    }

    func toggle() {
        if started {
            session?.end()
            session?.associatedWorkoutBuilder().discardWorkout()
        } else {
            session = try? HKWorkoutSession(healthStore: HKHealthStore(), configuration: HKWorkoutConfiguration())
            session?.startActivity(with: Date())
            session?.pause()
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}
}
