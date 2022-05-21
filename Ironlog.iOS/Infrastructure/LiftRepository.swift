//
//  LiftRepository.swift
//  Ironlog
//
//  Created by Brian Stauff on 5/21/22.
//

import Foundation

protocol LiftRepository {
    func getLift(liftId: UUID) throws -> Lift?
    func addLift(lift: Lift) throws
    func deleteLift(liftId: UUID) throws
    func saveLift(lift: Lift) throws
}
