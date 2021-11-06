//
//  Movement.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import Foundation

struct Movement {
    let movementName: String;
    let sets: [Set];
}

struct Set {
    let weight: Int;
    let reps: Int;
}

struct Workout {
    let mainSets: [Movement];
    let supplementalSets: [Movement];
    let assistanceSets: [Movement];
}

struct DailyPlan {
    let workout: Workout;
    let datetime: Date;
}
