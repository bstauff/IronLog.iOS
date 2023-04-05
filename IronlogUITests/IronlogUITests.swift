//
//  IronlogUITests.swift
//  IronlogUITests
//
//  Created by Brian Stauff on 10/31/21.
//

import XCTest

class IronlogUITests: XCTestCase {
    func testLiftsView() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        XCUIApplication().tabBars["Tab Bar"].buttons["Lifts"].tap()
        
        app.tabBars["Tab Bar"].buttons["Lifts"].tap()
        app.navigationBars["Lift Catalog"]/*@START_MENU_TOKEN@*/.buttons["Add"]/*[[".otherElements[\"Add\"].buttons[\"Add\"]",".buttons[\"Add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("02LiftsAddView")
        app.textFields["Lift name"].tap()
        app.textFields["Lift name"].typeText("Squat")
        
        app.textFields["Training Max"].tap()
        app.textFields["Training Max"].typeText("315")
        
        app.buttons["Save"].tap()
        snapshot("01LiftsView")
        app.launch()
    }
    
    func testMainView() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        app.tabBars["Tab Bar"].buttons["Workouts"].tap()
        app.navigationBars["Workouts"]/*@START_MENU_TOKEN@*/.buttons["add"]/*[[".otherElements[\"add\"].buttons[\"add\"]",".buttons[\"add\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let liftPicker = app.collectionViews/*@START_MENU_TOKEN@*/.staticTexts["Select Lift"]/*[[".cells",".buttons[\"Main Lift, Select Lift\"].staticTexts[\"Select Lift\"]",".staticTexts[\"Select Lift\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        liftPicker.tap()
        
        app.collectionViews.cells.element(boundBy: 1).tap()
        snapshot("03WorkoutsAddView")
        app.buttons["Create"].tap()
        snapshot("04WorkoutsView")
    }
    
    func testActiveWorkoutView() throws {
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        app.tabBars["Tab Bar"].buttons["Active Workout"].tap()
        app.collectionViews.buttons.element(boundBy: 0).tap()
        app.buttons["BEGIN"].tap()
        snapshot("05ActiveWorkoutView")
    }
}
