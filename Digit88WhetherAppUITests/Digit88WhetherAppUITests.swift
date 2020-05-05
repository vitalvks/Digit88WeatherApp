//
//  Digit88WhetherAppUITests.swift
//  Digit88WhetherAppUITests
//
//  Created by Sudhakar on 04/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import XCTest

class Digit88WhetherAppUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testTraditionalLoginFlow() {
        let app = XCUIApplication()
        app.launch()
        app.textFields["UserNameFld"].tap()
        app.textFields["UserNameFld"].typeText("abc")
        app.textFields["PasswordFld"].tap()
        app.textFields["PasswordFld"].typeText("abc")
        app.buttons["LoginBtn"].tap()
        sleep(1)
    }
    
    func testTouchIDButtonIsTappable() {
        let app = XCUIApplication()
        app.launch()
        app.buttons["TouchIDButton"].tap()
        sleep(1)
    }
    
    func testLogoutFlow() {
        let app = XCUIApplication()
        app.launch()
        app.textFields["UserNameFld"].tap()
        app.textFields["UserNameFld"].typeText("abc")
        app.textFields["PasswordFld"].tap()
        app.textFields["PasswordFld"].typeText("abc")
        app.buttons["LoginBtn"].tap()
        sleep(1)
        
        app.buttons["ProfileButton"].tap()
        sleep(1)
        app.buttons["LoginBtn"].tap()
        sleep(2)
    }
}
