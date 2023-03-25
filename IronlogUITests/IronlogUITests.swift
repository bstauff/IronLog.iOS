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
        
        app.textFields["Lift name"].tap()
        app.textFields["Lift name"].typeText("Squat")
        
        app.textFields["Training Max"].tap()
        app.textFields["Training Max"].typeText("315")
        
        app.buttons["Save"].tap()
        snapshot("01LiftsView")
        app.launch()
    }
}
