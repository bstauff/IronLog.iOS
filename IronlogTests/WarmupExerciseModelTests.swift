//
//  WarmupExerciseModel.swift
//  IronlogTests
//
//  Created by Brian Stauff on 3/9/23.
//

import Foundation
import XCTest
@testable import Ironlog

class WarmupExerciseModelTests: XCTestCase {

    func testPlanSetsForWeekShouldPlanCorrectlyForFirstWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let warmupExercise = WarmupExerciseModel(lift: lift)
        
        warmupExercise.planSetsForWeek(week: CycleWeek.firstWeek)
        
        XCTAssertEqual(3, warmupExercise.sets.count)
        
        XCTAssertEqual(90, warmupExercise.sets[0].weight)
        XCTAssertEqual(5, warmupExercise.sets[0].reps)
        
        XCTAssertEqual(115, warmupExercise.sets[1].weight)
        XCTAssertEqual(5, warmupExercise.sets[1].reps)
        
        XCTAssertEqual(135, warmupExercise.sets[2].weight)
        XCTAssertEqual(3, warmupExercise.sets[2].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForSecondWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let warmupExercise = WarmupExerciseModel(lift: lift)
        
        warmupExercise.planSetsForWeek(week: CycleWeek.secondWeek)
        
        XCTAssertEqual(3, warmupExercise.sets.count)
        
        XCTAssertEqual(90, warmupExercise.sets[0].weight)
        XCTAssertEqual(5, warmupExercise.sets[0].reps)
        
        XCTAssertEqual(115, warmupExercise.sets[1].weight)
        XCTAssertEqual(5, warmupExercise.sets[1].reps)
        
        XCTAssertEqual(135, warmupExercise.sets[2].weight)
        XCTAssertEqual(3, warmupExercise.sets[2].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForThirdWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let warmupExercise = WarmupExerciseModel(lift: lift)
        
        warmupExercise.planSetsForWeek(week: CycleWeek.thirdWeek)
        
        XCTAssertEqual(3, warmupExercise.sets.count)
        
        XCTAssertEqual(90, warmupExercise.sets[0].weight)
        XCTAssertEqual(5, warmupExercise.sets[0].reps)
        
        XCTAssertEqual(115, warmupExercise.sets[1].weight)
        XCTAssertEqual(5, warmupExercise.sets[1].reps)
        
        XCTAssertEqual(135, warmupExercise.sets[2].weight)
        XCTAssertEqual(3, warmupExercise.sets[2].reps)
    }
}
