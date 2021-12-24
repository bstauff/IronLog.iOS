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
        NavigationView {
            List {
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
            .navigationTitle("Ironlog")
        }
    }
}

struct LobbyView_Previews: PreviewProvider {
    static var previews: some View {
        LobbyView()
    }
}
