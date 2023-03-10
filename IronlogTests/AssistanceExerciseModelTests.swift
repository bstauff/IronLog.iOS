//
//  AssistanceExerciseModelTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 3/10/23.
//

import Foundation
import XCTest
@testable import Ironlog

class AssistanceExerciseModelTests: XCTestCase {
    func testPlanSetsForWeekShouldPlanCorrectlyForFirstWeek() {
        let lift = LiftModel(
            name: "Tricep Pushdown",
            trainingMax: 35,
            isMainLift: false)
        
        let assistanceExerciseModel = AssistanceExerciseModel(lift: lift)
        
        assistanceExerciseModel.planSetsForWeek(week: CycleWeek.firstWeek)
        
        XCTAssertEqual(5, assistanceExerciseModel.sets.count)
        
        XCTAssertEqual(35, assistanceExerciseModel.sets[0].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[0].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[1].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[1].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[2].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[2].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[3].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[3].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[4].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[4].reps)
    }
    func testPlanSetsForWeekShouldPlanCorrectlyForSecondWeek() {
        let lift = LiftModel(
            name: "Tricep Pushdown",
            trainingMax: 35,
            isMainLift: false)
        
        let assistanceExerciseModel = AssistanceExerciseModel(lift: lift)
        
        assistanceExerciseModel.planSetsForWeek(week: CycleWeek.secondWeek)
        
        XCTAssertEqual(5, assistanceExerciseModel.sets.count)
        
        XCTAssertEqual(35, assistanceExerciseModel.sets[0].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[0].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[1].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[1].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[2].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[2].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[3].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[3].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[4].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[4].reps)
    }
    func testPlanSetsForWeekShouldPlanCorrectlyForThirdWeek() {
        let lift = LiftModel(
            name: "Tricep Pushdown",
            trainingMax: 35,
            isMainLift: false)
        
        let assistanceExerciseModel = AssistanceExerciseModel(lift: lift)
        
        assistanceExerciseModel.planSetsForWeek(week: CycleWeek.thirdWeek)
        
        XCTAssertEqual(5, assistanceExerciseModel.sets.count)
        
        XCTAssertEqual(35, assistanceExerciseModel.sets[0].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[0].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[1].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[1].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[2].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[2].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[3].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[3].reps)
        XCTAssertEqual(35, assistanceExerciseModel.sets[4].weight)
        XCTAssertEqual(5, assistanceExerciseModel.sets[4].reps)
    }
}
