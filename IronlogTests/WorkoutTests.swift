//
//  WorkoutModelTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 2/26/23.
//

import Foundation
import XCTest
import CoreData

@testable import Ironlog

class WorkoutTests: XCTestCase {
    
    private var lift: Lift?
    private var workout: Workout?
    private var context: NSManagedObjectContext?
    
    override func setUp() async throws {
        self.context =
            PersistenceController.testController.container.viewContext
        
        self.lift = Lift(context: self.context!)
        
        self.workout = Workout(context: self.context!)
    }
    
    func testPlanForWeekShouldCreateMainWork() {
        let cycleWeek = CycleWeek.firstWeek
        self.workout?.planForWeek(lift: self.lift!, week: cycleWeek)
        
        XCTAssertNotNil(workout?.mainExercise?.exerciseSets)
        XCTAssertTrue(workout!.mainExercise!.exerciseSets!.count > 0)
    }
    
    func testPlanWorkoutShouldCreateSupplementalWork() {
        let cycleWeek = CycleWeek.firstWeek

        self.workout?.planForWeek(lift: self.lift!, week: cycleWeek)
        
        XCTAssertNotNil(workout?.supplementalExercise?.exerciseSets)
        XCTAssertTrue(workout!.supplementalExercise!.exerciseSets!.count > 0)
    }
    
    func testPlanAssistanceShouldCreateAssistanceWork() {
        self.workout!.planAssistance(assistanceLift: self.lift!)
        
        XCTAssertNotNil(workout?.assistanceExercises)
        let assistanceExercises: NSOrderedSet! = workout?.assistanceExercises
        XCTAssertEqual(1, assistanceExercises.count)
        let assistanceExercise = assistanceExercises.firstObject as! AssistanceExercise
        XCTAssertNotNil(assistanceExercise.exerciseSets)
        let assistanceSets: NSOrderedSet! = assistanceExercise.exerciseSets
        XCTAssertTrue(assistanceSets.count > 0)
    }
}
