//
//  WarmupExerciseModel.swift
//  IronlogTests
//
//  Created by Brian Stauff on 3/9/23.
//

import Foundation
import XCTest
import CoreData
@testable import Ironlog

class WarmupExerciseModelTests: XCTestCase {
    
    private var warmupExercise: WarmupExercise?
    private var context: NSManagedObjectContext?
    
    override func setUp() async throws {
        self.context = PersistenceController.testController.container.viewContext
        
        self.warmupExercise = WarmupExercise(context: self.context!)
        
        let lift = Lift(context: self.context!)
        lift.name = "Squat"
        lift.trainingMax = 225
        
        warmupExercise!.lift = lift
    }

    func testPlanSetsForWeekShouldPlanCorrectlyForFirstWeek() {
        warmupExercise!.planSetsForWeek(week: CycleWeek.firstWeek)
        
        XCTAssertNotNil(warmupExercise!.exerciseSets)
        
        let sets = warmupExercise?.exerciseSets?.array as! [ExerciseSet]
        
        XCTAssertEqual(3, sets.count)
        
        XCTAssertEqual(90, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        
        XCTAssertEqual(115, sets[1].weight)
        XCTAssertEqual(5, sets[1].reps)
        
        XCTAssertEqual(135, sets[2].weight)
        XCTAssertEqual(3, sets[2].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForSecondWeek() {
        warmupExercise!.planSetsForWeek(week: CycleWeek.secondWeek)
        
        XCTAssertNotNil(warmupExercise!.exerciseSets)
        
        let sets = warmupExercise?.exerciseSets?.array as! [ExerciseSet]
        
        XCTAssertEqual(3, sets.count)
        
        XCTAssertEqual(90, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        
        XCTAssertEqual(115, sets[1].weight)
        XCTAssertEqual(5, sets[1].reps)
        
        XCTAssertEqual(135, sets[2].weight)
        XCTAssertEqual(3, sets[2].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForThirdWeek() {
        warmupExercise!.planSetsForWeek(week: CycleWeek.thirdWeek)
        
        XCTAssertNotNil(warmupExercise!.exerciseSets)
        
        let sets = warmupExercise?.exerciseSets?.array as! [ExerciseSet]
        
        XCTAssertEqual(3, sets.count)
        
        XCTAssertEqual(90, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        
        XCTAssertEqual(115, sets[1].weight)
        XCTAssertEqual(5, sets[1].reps)
        
        XCTAssertEqual(135, sets[2].weight)
        XCTAssertEqual(3, sets[2].reps)
    }
}
