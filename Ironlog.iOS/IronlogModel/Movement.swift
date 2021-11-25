//
//  Movement.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import Foundation

struct LiftingSession {
   
    var liftingSessionID: UInt32
    var liftingSessionDate: Date
    
    var mainWork: Movement
    var supplementalWork: Movement
    var assistanceWork: [Movement]
}


struct Movement {
    var lift: Lift
    var sets: [Set]
}

struct Lift {
    var liftName: String
    var trainingMax: Int
}

struct Set {
    var weight: Int
    var reps: Int
    var isComplete: Bool
}
