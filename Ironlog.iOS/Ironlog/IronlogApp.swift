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
                ActiveWorkoutView(repository: repository)
                    .tabItem {
                        Label("Active Workout", systemImage: "flame.circle")
                    }
                    .tag(2)
                LiftsView(liftRepo: repository)
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
        do {
            let workouts = try repository.getAllWorkouts()
            self.workouts = workouts
        } catch {
           //error handling here
        }
    }
    private func loadLifts() {
        do {
            let lifts = try repository.getAllLifts()
            self.lifts = lifts
        } catch {
            //error handling here
        }
    }
}
