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
    
    func testPlanWorkoutShouldCreateMainWork() {
        let expectedDate = Date()
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let cycleWeek = CycleWeek.firstWeek
        let workout = WorkoutModel(
            workoutDate: expectedDate,
            cycleWeek: cycleWeek,
            mainLift: lift
        )
        
        XCTAssertNotNil(workout.mainExercise)
        XCTAssertTrue(workout.mainExercise.sets.count > 0)
    }
    
    func testPlanWorkoutShouldCreateSupplementalWork() {
        let expectedDate = Date()
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let cycleWeek = CycleWeek.firstWeek
        let workout = WorkoutModel(
            workoutDate: expectedDate,
            cycleWeek: cycleWeek,
            mainLift: lift
        )
        
        XCTAssertNotNil(workout.supplementalExercise)
        XCTAssertTrue(workout.supplementalExercise.sets.count > 0)
    }
    
    func testPlanWorkoutShouldCreateWarmupWork() {
        let expectedDate = Date()
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let cycleWeek = CycleWeek.firstWeek
        let workout = WorkoutModel(
            workoutDate: expectedDate,
            cycleWeek: cycleWeek,
            mainLift: lift
        )
        
        XCTAssertNotNil(workout.warmupExercise)
        XCTAssertTrue(workout.warmupExercise.sets.count > 0)
    }
}
