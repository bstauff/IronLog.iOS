//
//  MockMovementServiceProtocol.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/26/21.
//

import Foundation

struct MockLiftService : LiftServiceProtocol {
    
    func getLiftCatalog() -> LiftCatalog {
       return LiftCatalog(initialLifts: [
            Lift(liftName: "Squat", trainingMax: 350),
            Lift(liftName: "Bench", trainingMax: 250),
            Lift(liftName: "Deadlift", trainingMax: 450)
       ])
    }
}
