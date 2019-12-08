//
//  ArticleRequestMostViewedTests.swift
//  NYTTests
//
//  Created by Rupesh Jaiswal on 08/12/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import XCTest
@testable import NYT

class ArticleRequestMostViewedTests: XCTestCase {
    
    var articleRequest: ArticleRequest!
    var isSuccess = false
    
    override func setUp() {
        articleRequest = ArticleRequest()
    }
    
    override func tearDown() {
        articleRequest = nil
    }
    
    func testArticleRequestForMostViewedWithOffset0() {
        articleRequest.getArticles(for: .viewed, offset: 0, { [weak self] (article) in
            self?.isSuccess = true
            
            }, failure: { (error) in }, useMockData: false)
        
        let pred = NSPredicate(format: "isSuccess == true")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let result = XCTWaiter.wait(for: [exp], timeout: 10.0)
        if result == XCTWaiter.Result.completed {
            XCTAssert(isSuccess == true, "Get Most Viewed Articles failed")
        } else {
            XCTAssert(false, "The call to get the URL ran into some other error")
        }
    }
    
    func testArticleRequestForMostViewedWithOffset20() {
        articleRequest.getArticles(for: .viewed, offset: 20, { [weak self] (article) in
            self?.isSuccess = true
            
            }, failure: { (error) in }, useMockData: false)
        
        let pred = NSPredicate(format: "isSuccess == true")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let result = XCTWaiter.wait(for: [exp], timeout: 10.0)
        if result == XCTWaiter.Result.completed {
            XCTAssert(isSuccess == true, "Get Most Viewed Articles failed")
        } else {
            XCTAssert(false, "The call to get the URL ran into some other error")
        }
    }
    
    func testArticleRequestForMostViewedWithOffset40() {
        articleRequest.getArticles(for: .viewed, offset: 40, { [weak self] (article) in
            self?.isSuccess = true
            
            }, failure: { (error) in }, useMockData: false)
        
        let pred = NSPredicate(format: "isSuccess == true")
        let exp = expectation(for: pred, evaluatedWith: self, handler: nil)
        let result = XCTWaiter.wait(for: [exp], timeout: 10.0)
        if result == XCTWaiter.Result.completed {
            XCTAssert(isSuccess == true, "Get Most Viewed Articles failed")
        } else {
            XCTAssert(false, "The call to get the URL ran into some other error")
        }
    }
}
