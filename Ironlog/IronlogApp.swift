//
//  IronlogApp.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import SwiftUI

@main
struct IronlogApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
//                WorkoutsView(workoutRepo: repository, workouts: $workouts, lifts: $lifts)
                    Text("Workouts here someday")
                    .tabItem {
                        Label("Workouts", systemImage: "list.bullet.circle")
                    }
                    .tag(1)
//                ActiveWorkoutView(workouts: $workouts, repository: repository)
                    Text("Active workout here someday")
                    .tabItem {
                        Label("Active Workout", systemImage: "flame.circle")
                    }
                    .tag(2)
                LiftsView()
                    .tabItem {
                        Label("Lifts", systemImage: "arrow.up.circle")
                    }
                    .tag(3)
            }
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
