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
    
    @State private var workouts: [Workout] = []
    @State private var lifts: [Lift] = []
   
    var body: some Scene {
        WindowGroup {
            TabView {
                WorkoutsView(workoutRepo: repository, workouts: $workouts, lifts: $lifts)
                    .tabItem {
                        Label("Workouts", systemImage: "list.bullet.circle")
                    }
                    .tag(1)
                ActiveWorkoutView(workouts: $workouts, repository: repository)
                    .tabItem {
                        Label("Active Workout", systemImage: "flame.circle")
                    }
                    .tag(2)
                LiftsView(lifts: $lifts, liftRepo: repository)
                    .tabItem {
                        Label("Lifts", systemImage: "arrow.up.circle")
                    }
                    .tag(3)
            }
            .onAppear {
                loadWorkouts()
                loadLifts()
            }
        }
    }
    
    private func loadWorkouts() {
        let workouts = try! repository.getAllWorkouts()
        self.workouts = workouts
    }
    private func loadLifts() {
        let lifts = try! repository.getAllLifts()
        self.lifts = lifts
    }
}
