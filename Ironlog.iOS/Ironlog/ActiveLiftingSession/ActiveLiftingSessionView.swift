//
//  ContentView.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import SwiftUI


struct ActiveLiftingSessionView: View {
    @State private var activeLiftingSession: LiftingSession
    
    init(activeLiftingSession: LiftingSession) {
        self._activeLiftingSession = State(initialValue: activeLiftingSession)
    }
    
    var body: some View {
        VStack {
            Text("Active Lifting Session").font(.headline)
            Divider()
            TabView {
                ScrollView {
                    VStack {
                        MovementView(movement: activeLiftingSession.mainWork)
                    }
                }.tabItem {
                    Label("Main", systemImage: "list.dash")
                }
                
                ScrollView {
                    VStack {
                        MovementView(movement: activeLiftingSession.supplementalWork)
                    }
                }.tabItem {
                    Label("Supplemental", systemImage: "list.dash")
                }
                
                ScrollView {
                    VStack {
                        ForEach(0..<activeLiftingSession.assistanceWork.count) { index in
                            MovementView(movement: activeLiftingSession.assistanceWork[index])
                        }
                    }
                }.tabItem {
                    Label("Assistance", systemImage: "list.dash")
                }
            }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let workoutService = MockLiftingSessionService()
        let mockSession = workoutService.getLiftingSession()
        
        
        ActiveLiftingSessionView(activeLiftingSession: mockSession)
    }
}
