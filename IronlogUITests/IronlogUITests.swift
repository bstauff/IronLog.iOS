//
//  IronlogUITests.swift
//  IronlogUITests
//
//  Created by Brian Stauff on 10/31/21.
//

import XCTest

class IronlogUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNavigateToLiftsShouldLoadView() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.buttons["Lifts"].tap()
        
        let text = app.staticTexts["Lift Catalog"].label
        
        XCTAssertEqual("Lift Catalog", text)
    }
    
    func testNavigateToActiveWorkoutShouldLoadView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Active Workout"].tap()
        let text = app.staticTexts["Choose a workout"].label
        XCTAssertEqual("Choose a workout", text)
    }
    
    func testNavigateToWorkoutsShouldLoadView() throws {
        let app = XCUIApplication()
        app.launch()
        app.tabBars["Tab Bar"].buttons["Workouts"].tap()
        
        let text = app.staticTexts["Workouts"].label
        XCTAssertEqual("Workouts", text)
    }
    

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
