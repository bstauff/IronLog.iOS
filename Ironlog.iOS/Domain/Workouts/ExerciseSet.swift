//
//  Set.swift
//  IronlogTests
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

struct ExerciseSet: Identifiable, Hashable {
    var id = UUID()
    var reps: Int
    var weight: Int
    var isComplete = false
    init(reps: Int, weight: Int) {
        self.reps = reps
        self.weight = weight
    }
    init(reps: Int, weight: Int, id: UUID) {
        self.reps = reps
        self.weight = weight
        self.id = id
    }
}
