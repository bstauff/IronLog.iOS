//
//  WorkoutModelTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 2/26/23.
//

import Foundation
import XCTest

@testable import Ironlog

class WorkoutModelTests: XCTestCase {
    func testWorkoutModelCreatesMainExercise() {
        let squat = LiftModel(name: "squat", trainingMax: 225)
        let workout = WorkoutModel(mainLift: squat, date: Date(), workoutWeek: WorkoutWeeks.firstWeek)
        
        XCTAssertEqual(3, workout.mainExercise.sets.count)
    }
}
