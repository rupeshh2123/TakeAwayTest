//
//  DashboardTest.swift
//  NYTTests
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//


import XCTest
@testable import NYT

class DashboardTest: XCTestCase {
    
    var dashboardViewController: DashboardViewController!

    override func setUp() {
        dashboardViewController = DashboardViewController()
    }
    
    override func tearDown() {
        dashboardViewController = nil
        
    }
    
    func testDashboardLoading() {
        let view = dashboardViewController.view
        XCTAssertNotNil(view, "Could not load View")

    }
 
}
