//
//  Movement.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import Foundation

struct Movement {
    let movementName: String;
    let weight: Int;
}

struct Set {
    let reps: Int;
    let movement: Movement;
}

struct Workout {
    let mainSets: [Set];
    let supplementalSets: [Set];
    let assistanceSets: [Set];
}

struct DailyPlan {
    let workout: Workout;
    let datetime: Date;
}
