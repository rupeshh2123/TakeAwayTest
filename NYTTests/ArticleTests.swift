//
//  ArticleTests.swift
//  NYTTests
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//


import XCTest
@testable import NYT

class ArticleTests: XCTestCase {
    
    var articleViewController: ArticleViewController!
    
    override func setUp() {
        articleViewController = ArticleViewController()
    }
    
    override func tearDown() {
        articleViewController = nil
    }
    
    func testArticleLoading() {
        let view = articleViewController.view
        XCTAssertNotNil(view, "Could not load View")
    }
}
