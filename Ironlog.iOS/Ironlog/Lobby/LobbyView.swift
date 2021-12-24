//
//  LobbyView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/8/21.
//

import SwiftUI

struct LobbyView: View {
    let workoutService = MockLiftingSessionService()
    var body: some View {
        VStack {
            Text("Ironlog").font(.largeTitle)
            NavigationView {
                VStack(alignment: .leading, spacing: 50) {
                    NavigationLink(destination: LiftCatalogView()){
                        Text("Lift Catalog")
                    }
                    NavigationLink(destination: WorkoutPlanner()){
                        Text("Workout planner")
                    }
                    NavigationLink(destination: ActiveLiftingSessionView(activeLiftingSession: workoutService.getLiftingSession())){
                        Text("Active Workout")
                    }
                }
            }
            }
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView()
    }
}
