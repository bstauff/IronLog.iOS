//
//  Exercise.swift
//  IronlogTests
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

class Exercise: Identifiable, ObservableObject, Hashable {
    
    
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
    
    static func == (lhs: Exercise, rhs: Exercise) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(sets)
        hasher.combine(lift)
        hasher.combine(isComplete)
    }
}
