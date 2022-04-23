//
//  Set.swift
//  IronlogTests
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

struct ExerciseSet: Identifiable {
    var id = UUID()
    var reps: Int
    var weight: Int
    var isComplete = false
    init(reps: Int, weight: Int) {
        self.reps = reps
        self.weight = weight
    }
}
