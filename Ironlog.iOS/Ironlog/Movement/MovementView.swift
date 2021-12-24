//
//  Movement.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/6/21.
//

import SwiftUI

struct MovementView: View {
    @State var movement: Movement
    
    var body: some View {
        VStack {
            Text(movement.lift.liftName)
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
        let mockWorkoutService = MockLiftingSessionService()
        let workout = mockWorkoutService.getMovement()
        MovementView(movement: workout)
        
    }
}
