//
//  SearchArticleTests.swift
//  NYTTests
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//


import XCTest
@testable import NYT

class SearchArticleTests: XCTestCase {
    
    var searchArticleViewController: SearchArticleViewController!
    
    override func setUp() {
        searchArticleViewController = SearchArticleViewController()
    }
    
    override func tearDown() {
        searchArticleViewController = nil
    }
    
    func testSearchLoading() {
        let view = searchArticleViewController.view
        XCTAssertNotNil(view, "Could not load View")
    }
}
