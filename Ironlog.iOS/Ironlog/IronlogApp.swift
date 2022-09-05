//
//  IronlogApp.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import SwiftUI

@main
struct IronlogApp: App {
    private var repository  = CoreDataRepository()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                WorkoutsView(workoutRepo: repository).tabItem {
                    Label("Cycle", systemImage: "list.bullet.circle")
                }
                let currentDate = Date()
                let activeWorkout = try? repository.getWorkoutForDate(date: currentDate)
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
                LiftsView(liftRepo: repository).tabItem {
                    Label("Lifts", systemImage: "arrow.up.circle")
                }
            }
        }
    }
}
