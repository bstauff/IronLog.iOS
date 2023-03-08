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
        let workout = WorkoutModel(mainLift: squat, date: Date(), workoutWeek: CycleWeek.firstWeek)
        
        XCTAssertEqual(3, workout.mainExercise.sets.count)
    }
    
    func iDontKnowWhatImDoing() {
        // user creates a cycle starting on a given date
        let cycle = Cycle(startDate: Date())
        
        // user schedules a main lift for the cycle
        // including accompanying assistance work
        cycle.ScheduleMainLift(mainLift)
        
        //user can only schedule a MAX of 4 lifts
    }
    
}
