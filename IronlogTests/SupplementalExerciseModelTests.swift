//
//  SupplementalExerciseModelTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 3/9/23.
//

import Foundation
import XCTest
@testable import Ironlog

class SupplementalExerciseModelTests: XCTestCase {
    
    func testPlanSetsForWeekShouldPlanCorrectlyForFirstWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let supplementalExercise = SupplementalExerciseModel(lift: lift)
        
        supplementalExercise.planSetsForWeek(week: CycleWeek.firstWeek)
        
        XCTAssertEqual(5, supplementalExercise.sets.count)
        
        XCTAssertEqual(145, supplementalExercise.sets[0].weight)
        XCTAssertEqual(5, supplementalExercise.sets[0].reps)
        XCTAssertEqual(145, supplementalExercise.sets[1].weight)
        XCTAssertEqual(5, supplementalExercise.sets[1].reps)
        XCTAssertEqual(145, supplementalExercise.sets[2].weight)
        XCTAssertEqual(5, supplementalExercise.sets[2].reps)
        XCTAssertEqual(145, supplementalExercise.sets[3].weight)
        XCTAssertEqual(5, supplementalExercise.sets[3].reps)
        XCTAssertEqual(145, supplementalExercise.sets[4].weight)
        XCTAssertEqual(5, supplementalExercise.sets[4].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForSecondWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let supplementalExercise = SupplementalExerciseModel(lift: lift)
        
        supplementalExercise.planSetsForWeek(week: CycleWeek.secondWeek)

        XCTAssertEqual(5, supplementalExercise.sets.count)
        
        XCTAssertEqual(160, supplementalExercise.sets[0].weight)
        XCTAssertEqual(5, supplementalExercise.sets[0].reps)
        XCTAssertEqual(160, supplementalExercise.sets[1].weight)
        XCTAssertEqual(5, supplementalExercise.sets[1].reps)
        XCTAssertEqual(160, supplementalExercise.sets[2].weight)
        XCTAssertEqual(5, supplementalExercise.sets[2].reps)
        XCTAssertEqual(160, supplementalExercise.sets[3].weight)
        XCTAssertEqual(5, supplementalExercise.sets[3].reps)
        XCTAssertEqual(160, supplementalExercise.sets[4].weight)
        XCTAssertEqual(5, supplementalExercise.sets[4].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForThirdWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let supplementalExercise = SupplementalExerciseModel(lift: lift)
        
        supplementalExercise.planSetsForWeek(week: CycleWeek.thirdWeek)
        
        XCTAssertEqual(5, supplementalExercise.sets.count)
        
        XCTAssertEqual(170, supplementalExercise.sets[0].weight)
        XCTAssertEqual(5, supplementalExercise.sets[0].reps)
        XCTAssertEqual(170, supplementalExercise.sets[1].weight)
        XCTAssertEqual(5, supplementalExercise.sets[1].reps)
        XCTAssertEqual(170, supplementalExercise.sets[2].weight)
        XCTAssertEqual(5, supplementalExercise.sets[2].reps)
        XCTAssertEqual(170, supplementalExercise.sets[3].weight)
        XCTAssertEqual(5, supplementalExercise.sets[3].reps)
        XCTAssertEqual(170, supplementalExercise.sets[4].weight)
        XCTAssertEqual(5, supplementalExercise.sets[4].reps)
    }
}
