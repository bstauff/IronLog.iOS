//
//  SupplementalExerciseModelTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 3/9/23.
//

import Foundation
import XCTest
import CoreData
@testable import Ironlog

class SupplementalExerciseModelTests: XCTestCase {
    
    private var supplementalExercise: SupplementalExercise?
    private var context: NSManagedObjectContext?
    
    override func setUp() async throws {
        self.context =
            PersistenceController.testController.container.viewContext
        
        self.supplementalExercise = SupplementalExercise(context: self.context!)
        
        let lift = Lift(context: self.context!)
        lift.name = "Squat"
        lift.trainingMax = 225
        
        supplementalExercise!.lift = lift
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForFirstWeek() {
        supplementalExercise!.planSetsForWeek(week: CycleWeek.firstWeek)
        
        XCTAssertNotNil(supplementalExercise?.exerciseSets)
        
        let sets = supplementalExercise?.exerciseSets?.array as! [ExerciseSet]
        
        XCTAssertEqual(5, sets.count)
        
        XCTAssertEqual(145, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        XCTAssertEqual(145, sets[1].weight)
        XCTAssertEqual(5, sets[1].reps)
        XCTAssertEqual(145, sets[2].weight)
        XCTAssertEqual(5, sets[2].reps)
        XCTAssertEqual(145, sets[3].weight)
        XCTAssertEqual(5, sets[3].reps)
        XCTAssertEqual(145, sets[4].weight)
        XCTAssertEqual(5, sets[4].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForSecondWeek() {
        supplementalExercise!.planSetsForWeek(week: CycleWeek.secondWeek)
        
        XCTAssertNotNil(supplementalExercise?.exerciseSets)
        
        let sets = supplementalExercise?.exerciseSets?.array as! [ExerciseSet]

        XCTAssertEqual(5, sets.count)
        
        XCTAssertEqual(160, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        XCTAssertEqual(160, sets[1].weight)
        XCTAssertEqual(5, sets[1].reps)
        XCTAssertEqual(160, sets[2].weight)
        XCTAssertEqual(5, sets[2].reps)
        XCTAssertEqual(160, sets[3].weight)
        XCTAssertEqual(5, sets[3].reps)
        XCTAssertEqual(160, sets[4].weight)
        XCTAssertEqual(5, sets[4].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForThirdWeek() {
        supplementalExercise!.planSetsForWeek(week: CycleWeek.thirdWeek)
        
        XCTAssertNotNil(supplementalExercise?.exerciseSets)
        
        let sets = supplementalExercise?.exerciseSets?.array as! [ExerciseSet]
        
        XCTAssertEqual(5, sets.count)
        
        XCTAssertEqual(170, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        XCTAssertEqual(170, sets[1].weight)
        XCTAssertEqual(5, sets[1].reps)
        XCTAssertEqual(170, sets[2].weight)
        XCTAssertEqual(5, sets[2].reps)
        XCTAssertEqual(170, sets[3].weight)
        XCTAssertEqual(5, sets[3].reps)
        XCTAssertEqual(170, sets[4].weight)
        XCTAssertEqual(5, sets[4].reps)
    }
}
