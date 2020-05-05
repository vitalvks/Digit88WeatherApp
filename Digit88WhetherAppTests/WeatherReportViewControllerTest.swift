//
//  WeatherReportViewControllerTest.swift
//  Digit88WhetherAppTests
//
//  Created by Sudhakar on 04/05/20.
//  Copyright © 2020 Sudhakar. All rights reserved.
//

import XCTest
@testable import Digit88WhetherApp

class WeatherReportViewControllerTest: XCTestCase {
    
    var weatherReportVC: WeatherReportViewController!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.weatherReportVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherReportViewController") as? WeatherReportViewController
        self.weatherReportVC.loadView()
        self.weatherReportVC.viewDidLoad()
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
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(self.weatherReportVC.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(self.weatherReportVC.responds(to: #selector(self.weatherReportVC.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(self.weatherReportVC.responds(to: #selector(self.weatherReportVC.tableView(_:cellForRowAt:))))
        XCTAssertTrue(self.weatherReportVC.responds(to: #selector(self.weatherReportVC.tableView(_:didSelectRowAt:))))
    }
    
    func testCollectionViewConformsToCollectionViewDataSourceProtocol() {
        XCTAssertTrue(self.weatherReportVC.conforms(to: UICollectionViewDataSource.self))
        XCTAssertTrue(self.weatherReportVC.responds(to: #selector(self.weatherReportVC.collectionView(_:numberOfItemsInSection:))))
        XCTAssertTrue(self.weatherReportVC.responds(to: #selector(self.weatherReportVC.collectionView(_:cellForItemAt:))))
    }


}
