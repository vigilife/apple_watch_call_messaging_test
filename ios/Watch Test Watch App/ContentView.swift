//
//  ContentView.swift
//  Watch Test Watch App
//
//  Created by Rexios on 1/31/23.
//

import SwiftUI

struct ContentView: View {
    @State var started = false
    
    var body: some View {
        VStack {
            Button(action: {
            }) {
                Text("\(started ? "Stop" : "Start")")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
