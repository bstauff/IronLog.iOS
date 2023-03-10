//
//  MainExerciseModelTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 3/9/23.
//

import Foundation
import XCTest
@testable import Ironlog

class MainExerciseModelTests: XCTestCase {
    
    func testPlanSetsForWeekShouldPlanCorrectlyForFirstWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let mainExercise = MainExerciseModel(lift: lift)
        
        mainExercise.planSetsForWeek(week: CycleWeek.firstWeek)
        
        XCTAssertEqual(3, mainExercise.sets.count)
        
        XCTAssertEqual(145, mainExercise.sets[0].weight)
        XCTAssertEqual(5, mainExercise.sets[0].reps)
        
        XCTAssertEqual(170, mainExercise.sets[1].weight)
        XCTAssertEqual(5, mainExercise.sets[1].reps)
        
        XCTAssertEqual(190, mainExercise.sets[2].weight)
        XCTAssertEqual(5, mainExercise.sets[2].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForSecondWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let mainExercise = MainExerciseModel(lift: lift)
        
        mainExercise.planSetsForWeek(week: CycleWeek.secondWeek)
        
        XCTAssertEqual(3, mainExercise.sets.count)
        
        XCTAssertEqual(160, mainExercise.sets[0].weight)
        XCTAssertEqual(3, mainExercise.sets[0].reps)
        
        XCTAssertEqual(180, mainExercise.sets[1].weight)
        XCTAssertEqual(3, mainExercise.sets[1].reps)
        
        XCTAssertEqual(205, mainExercise.sets[2].weight)
        XCTAssertEqual(3, mainExercise.sets[2].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForThirdWeek() {
        let lift = LiftModel(name: "Squat", trainingMax: 225, isMainLift: true)
        let mainExercise = MainExerciseModel(lift: lift)
        
        mainExercise.planSetsForWeek(week: CycleWeek.thirdWeek)
        
        XCTAssertEqual(3, mainExercise.sets.count)
        
        XCTAssertEqual(170, mainExercise.sets[0].weight)
        XCTAssertEqual(5, mainExercise.sets[0].reps)
        
        XCTAssertEqual(190, mainExercise.sets[1].weight)
        XCTAssertEqual(3, mainExercise.sets[1].reps)
        
        XCTAssertEqual(215, mainExercise.sets[2].weight)
        XCTAssertEqual(1, mainExercise.sets[2].reps)
    }
}
