//
//  IronlogApp.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import SwiftUI

@main
struct IronlogApp: App {
    @StateObject var liftCatalog = LiftCatalog()
    @StateObject var cyclePlan = Cycle()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                CycleView(cycle: cyclePlan, liftCatalog: liftCatalog).tabItem {
                    Label("Cycle", systemImage: "list.bullet.circle")
                }
                let activeWorkout = cyclePlan.getActiveWorkout()
                if activeWorkout != nil {
                    ActiveWorkoutView(workout: activeWorkout!).tabItem {
                        Label("Active Workout", systemImage: "flame.circle")
                    }
                } else {
                    Text("No currently active workout.  Go plan one!")
                        .tabItem {
                            Label("Active Workout", systemImage: "flame.circle")
                        }
                }
                LiftCatalogView(liftCatalog: liftCatalog).tabItem {
                    Label("Lifts", systemImage: "arrow.up.circle")
                }
            }
        }
    }
}
