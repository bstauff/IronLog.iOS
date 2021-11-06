//
//  ContentView.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import SwiftUI


struct ActiveWorkoutView: View {
    @State
    private var activeWorkout: Workout;
    
    init(activeWorkout: Workout) {
        self.activeWorkout = activeWorkout;
    }
    
    var body: some View {
        TabView {
            ScrollView {
                VStack {
                    MovementView(movement: activeWorkout.mainMovement)
                }
            }.tabItem {
                Label("Main", systemImage: "list.dash")
            }
            
            ScrollView {
                VStack {
                    MovementView(movement: activeWorkout.supplementalMovement)
                }
            }.tabItem {
                Label("Supplemental", systemImage: "list.dash")
            }
            
            ScrollView {
                VStack {
                    ForEach(0..<activeWorkout.assistanceMovements.count) { index in
                        MovementView(movement: activeWorkout.assistanceMovements[index])
                    }
                }
            }.tabItem {
                Label("Assistance", systemImage: "list.dash")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let workoutService = MockDataWorkoutService()
        
        
        ActiveWorkoutView(activeWorkout: workoutService.getWorkouts())
    }
}
