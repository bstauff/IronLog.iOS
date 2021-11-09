//
//  WorkoutServiceProtocol.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/6/21.
//

import Foundation

protocol LiftingDataServiceProtocol {
    func getLiftingSession() -> LiftingSession
    func getMovement() -> Movement
}
