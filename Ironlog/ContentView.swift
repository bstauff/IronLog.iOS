//
//  ContentView.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import SwiftUI


struct ContentView: View {
    @State
    private var workoutOfTheDay: Workout;
    
    init(workout: Workout) {
        workoutOfTheDay = workout;
    }
    
    var body: some View {
//        Text("Hello, world!")
//            .padding()
        VStack {
            Text("Movements")
            Divider()
            ForEach(0..<workoutOfTheDay.mainSets.count) { value in
                Text(workoutOfTheDay.mainSets[value].movement.movementName)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
        ContentView(
            workout:
            Workout(
                mainSets: [
                    Set(
                        reps: 10,
                        movement: Movement(
                            movementName: "Squat",
                            weight: 250))],
                supplementalSets: [
                    Set(
                        reps: 10,
                        movement: Movement(
                            movementName: "Bench",
                            weight: 175))
                ],
                assistanceSets: [
                    Set(
                        reps: 12,
                        movement: Movement(
                            movementName: "Tricep Push",
                            weight: 35))
                ]))
    }
}
