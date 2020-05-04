//
//  WeatherReportUITest.swift
//  Digit88WhetherAppUITests
//
//  Created by Balaji Sivaji on 04/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import XCTest

class WeatherReportUITest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testNavigateToWeatherScreen() {
        let app = XCUIApplication()
        app.launch()
        app.textFields["UserNameFld"].tap()
        app.textFields["UserNameFld"].typeText("abc")
        app.textFields["PasswordFld"].tap()
        app.textFields["PasswordFld"].typeText("abc")
        app.buttons["LoginBtn"].tap()
        sleep(1)
    }
    
    func testSearchBarfunctioninWeatherScreen() {
        let app = XCUIApplication()
        app.launch()
        app.textFields["UserNameFld"].tap()
        app.textFields["UserNameFld"].typeText("abc")
        app.textFields["PasswordFld"].tap()
        app.textFields["PasswordFld"].typeText("abc")
        app.buttons["LoginBtn"].tap()
        sleep(1)
        let searchField = XCUIApplication().searchFields.firstMatch
        searchField.tap()
        searchField.typeText("Hosu")
        sleep(3)
    }

}
