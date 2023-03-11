//
//  MainExerciseModelTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 3/9/23.
//

import Foundation
import XCTest
import CoreData
@testable import Ironlog

class MainExerciseModelTests: XCTestCase {
    
    private var mainExercise: MainExercise?
    private var context: NSManagedObjectContext?
    
    override func setUp() async throws {
        self.context = PersistenceController.testController.container.viewContext
        
        self.mainExercise = MainExercise(context: self.context!)
        
        let lift = Lift(context: self.context!)
        lift.name = "Squat"
        lift.trainingMax = 225
        
        mainExercise!.lift = lift
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForFirstWeek() {
        mainExercise!.planSetsForWeek(week: CycleWeek.firstWeek)
        
        XCTAssertNotNil(mainExercise?.exerciseSets)
        
        let sets = mainExercise?.exerciseSets?.array as! [ExerciseSet]
        
        XCTAssertEqual(3, sets.count)
        
        XCTAssertEqual(145, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        
        XCTAssertEqual(170, sets[1].weight)
        XCTAssertEqual(5, sets[1].reps)
        
        XCTAssertEqual(190, sets[2].weight)
        XCTAssertEqual(5, sets[2].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForSecondWeek() {
        
        mainExercise!.planSetsForWeek(week: CycleWeek.secondWeek)
        
        XCTAssertNotNil(mainExercise?.exerciseSets)
        
        let sets = mainExercise?.exerciseSets?.array as! [ExerciseSet]
        
        XCTAssertEqual(3, sets.count)
        
        XCTAssertEqual(160, sets[0].weight)
        XCTAssertEqual(3, sets[0].reps)
        
        XCTAssertEqual(180, sets[1].weight)
        XCTAssertEqual(3, sets[1].reps)
        
        XCTAssertEqual(205, sets[2].weight)
        XCTAssertEqual(3, sets[2].reps)
    }
    
    func testPlanSetsForWeekShouldPlanCorrectlyForThirdWeek() {
        mainExercise!.planSetsForWeek(week: CycleWeek.thirdWeek)
        
        XCTAssertNotNil(mainExercise?.exerciseSets)
        
        let sets = mainExercise?.exerciseSets?.array as! [ExerciseSet]
        
        XCTAssertEqual(3, sets.count)
        
        XCTAssertEqual(170, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        
        XCTAssertEqual(190, sets[1].weight)
        XCTAssertEqual(3, sets[1].reps)
        
        XCTAssertEqual(215, sets[2].weight)
        XCTAssertEqual(1, sets[2].reps)
    }
}
