//
//  AssistanceExerciseModelTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 3/10/23.
//

import Foundation
import XCTest
import CoreData
@testable import Ironlog

class AssistanceExerciseModelTests: XCTestCase {
    private var lift: Lift?
    private var workout: Workout?
    private var context: NSManagedObjectContext?
    
    override func setUp() async throws {
        self.context =
            PersistenceController.testController.container.viewContext
        
        self.lift = Lift(context: self.context!)
        lift?.name = "Tricep Pushdown"
        lift?.trainingMax = 35
        
        self.workout = Workout(context: self.context!)
    }
    func testPlanSetsForWeekShouldPlanCorrectlyForFirstWeek() {
        self.workout?.planAssistance(assistanceLift: self.lift!)
        
        XCTAssertNotNil(self.workout?.assistanceExercises)
        let assistanceExercise = self.workout!.assistanceExercises!.firstObject as! AssistanceExercise
        
        XCTAssertNotNil(assistanceExercise.exerciseSets)
        
        let sets: [ExerciseSet] = assistanceExercise.exerciseSets!.array as! [ExerciseSet]
        
        XCTAssertEqual(5, sets.count)
        
        XCTAssertEqual(35, sets[0].weight)
        XCTAssertEqual(5, sets[0].reps)
        XCTAssertEqual(35, sets[1].weight)
        XCTAssertEqual(5, sets[1].reps)
        XCTAssertEqual(35, sets[2].weight)
        XCTAssertEqual(5, sets[2].reps)
        XCTAssertEqual(35, sets[3].weight)
        XCTAssertEqual(5, sets[3].reps)
        XCTAssertEqual(35, sets[4].weight)
        XCTAssertEqual(5, sets[4].reps)
    }
}
