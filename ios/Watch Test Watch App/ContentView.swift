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

class Controller: ObservableObject {
    @Published var started = false
    var session: HKWorkoutSession?
    var count = 0

    init() {
        WCSession.default.activate()
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
}
