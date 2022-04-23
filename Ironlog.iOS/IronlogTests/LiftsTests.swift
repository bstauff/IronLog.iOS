//
//  LiftsTests.swift
//  IronlogTests
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation
import XCTest
@testable import Ironlog


class LiftsTests : XCTestCase {
    func testLiftCatalogAddWithNoExistingLift() throws {
        let lift = Lift(name: "squat", trainingMax: 315)
        
        let liftCatalog = LiftCatalog()
        
        try liftCatalog.addLift(newLift: lift)
        
        XCTAssertEqual(1, liftCatalog.lifts.count)
    }
    
    func testLiftCatalogAddWithExistingLift() throws {
        let lift = Lift(name: "squat", trainingMax: 315)
        
        let liftCatalog = LiftCatalog()
        
        try liftCatalog.addLift(newLift: lift)
        
        
        XCTAssertThrowsError(try liftCatalog.addLift(newLift: lift))
    }
}
