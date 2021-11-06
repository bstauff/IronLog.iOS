//
//  Movement.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/6/21.
//

import SwiftUI

struct MovementView: View {
    init(movement: Movement) {
        
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Movement_Previews: PreviewProvider {
    static var previews: some View {
        MovementView(movement:Movement(movementName: "Squat", sets: [Set(weight: 255, reps: 5)]))
        
    }
}
