//
//  Exercise.swift
//  IronlogTests
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

class Exercise: Identifiable, ObservableObject {
    var id = UUID()
    @Published var sets: [ExerciseSet]
    @Published var lift: Lift
    @Published var isComplete = false
    
    init() {
        id = UUID()
        sets = []
        lift = Lift(name: "New Lift", trainingMax: 0)
    }
    
    init(
        id: UUID,
        sets: [ExerciseSet],
        lift: Lift,
        isComplete: Bool
    ) {
        self.id = id
        self.sets = sets
        self.lift = lift
        self.isComplete = isComplete
    }
}
