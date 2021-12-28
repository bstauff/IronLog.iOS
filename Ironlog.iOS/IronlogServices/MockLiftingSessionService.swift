//
//  MockDataWorkoutService.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/6/21.
//

import Foundation

struct MockLiftingSessionService : LiftingDataServiceProtocol {
    func getMovement() -> Movement {
       return Movement(
        lift: Lift(
            liftName: "Squat",
            trainingMax: 315
        ),
        sets: [
            MovementSet(weight: 200, reps: 5, isComplete: false),
            MovementSet(weight: 200, reps: 5, isComplete: false),
            MovementSet(weight: 200, reps: 5, isComplete: false),
        ]
       )
    }
    
    func getLiftingSession() -> LiftingSession {
       return LiftingSession(
        liftingSessionID: UInt32.random(in: 1..<200000),
        liftingSessionDate: Date.now,
        
        mainWork: getMovement(),
        supplementalWork: getMovement(),
        assistanceWork: [
            getMovement(),
            getMovement(),
            getMovement()
        ]
       )
    }
}
