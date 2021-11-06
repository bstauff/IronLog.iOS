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
        VStack {
            Text("Movements")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        let sampleWorkout = Workout(
            mainMovement: Movement(
                movementName: "Squat",
                sets: [
                    Set(weight: 255, reps: 5),
                    Set(weight: 275, reps: 3),
                    Set(weight:275, reps: 1)]),
            supplementalMovement: Movement(
                movementName: "Squat",
                sets: [
                    Set(weight: 175, reps: 5),
                    Set(weight: 175, reps: 5),
                    Set(weight: 175, reps: 5),
                    Set(weight: 175, reps: 5),
                    Set(weight: 175, reps: 5)
                ]
            ),
            assistanceMovements: [
                Movement(movementName: "Tricep Pushdown", sets: [Set(weight: 45, reps: 12)])
            ]
        )
        
        ActiveWorkoutView(activeWorkout: sampleWorkout)
    }
}
