//
//  Movement.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import Foundation

struct Movement {
    var movementName: String
    var sets: [Set]
}

struct Set {
    var weight: Int
    var reps: Int
    var isComplete: Bool = false
}

struct Workout {
    var mainMovement: Movement
    var supplementalMovement: Movement
    var assistanceMovements: [Movement]
}

struct DailyPlan {
    var workout: Workout
    var datetime: Date
}
