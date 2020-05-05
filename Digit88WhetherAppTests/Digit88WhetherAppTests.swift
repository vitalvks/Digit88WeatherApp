//
//  Digit88WhetherAppTests.swift
//  Digit88WhetherAppTests
//
//  Created by Sudhakar on 04/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import XCTest
@testable import Digit88WhetherApp

class Digit88WhetherAppTests: XCTestCase {

    var signInVC: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.signInVC =  UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewController") as? ViewController
        self.signInVC.loadView()
        self.signInVC.viewDidLoad()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testAuthenticationMethodAdded() {
        self.signInVC.responds(to: Selector(("authenticateUserTouchID")))
    }
    
    func testFaceBookIntegrationAvailability() {
        self.signInVC.responds(to: Selector(("facebookLoginSetup")))
    }
    
    func testNavigateToWeatherScreenMethodAvailability() {
        self.signInVC.responds(to: Selector(("navigateToWeatherReportScreen")))
    }

}
