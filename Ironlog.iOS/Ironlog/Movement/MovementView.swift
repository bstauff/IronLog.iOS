//
//  Movement.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/6/21.
//

import SwiftUI

struct MovementView: View {
    @State private var movement: Movement
    
    init(movement: Movement) {
        self.movement = movement
    }
    
    var body: some View {
        VStack {
            Text(movement.movementName)
            Divider()
            ForEach(0..<movement.sets.count) {index in
                HStack {
                    VStack {
                        Text(String(movement.sets[index].weight)+"lbs")
                    }
                    VStack {
                        Text(String(movement.sets[index].reps)+" reps")
                    }
                    Toggle(isOn:$movement.sets[index].isComplete) {
                        if(movement.sets[index].isComplete) {
                            Text("Done")
                        } else {
                            Text("To do")
                        }
                    }.toggleStyle(ButtonToggleStyle())
                }
            }
            Divider()
        }
    }
}

struct Movement_Previews: PreviewProvider {
    static var previews: some View {
        let mockWorkoutService = MockDataWorkoutService()
        let workout = mockWorkoutService.getWorkouts()
        MovementView(movement: workout.mainMovement)
        
    }
}
