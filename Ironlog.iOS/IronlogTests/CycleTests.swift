//
//  CycleTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 2/12/22.
//

import Foundation
import XCTest
@testable import Ironlog

class CycleTests : XCTestCase {
    func testCycleGetActiveWorkout() throws {
        let cycle = Cycle()
        let set = ExerciseSet(reps: 5, weight: 300)
        let exercise = Exercise(sets: [set], liftId: UUID())
        
        let todaysWorkout = Workout(date: Date(), mainWork: exercise, supplementalWork: exercise, assistanceWork: [exercise])
        
        cycle.workouts.append(todaysWorkout)
        
        XCTAssertNotNil(cycle.getActiveWorkout())
        
        cycle.workouts.removeAll()
        
        XCTAssertNil(cycle.getActiveWorkout())
    }
}
