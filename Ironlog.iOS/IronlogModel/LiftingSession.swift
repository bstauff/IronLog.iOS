//
//  Movement.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/31/21.
//

import Foundation

struct LiftingSession : Hashable {
   
    var liftingSessionID: UInt32
    var liftingSessionDate: Date
    
    var mainWork: Movement
    var supplementalWork: Movement
    var assistanceWork: [Movement]
}


struct Movement : Hashable {
    var lift: Lift
    var sets: [MovementSet]
}


struct MovementSet : Hashable {
    var weight: Int
    var reps: Int
    var isComplete: Bool
}
