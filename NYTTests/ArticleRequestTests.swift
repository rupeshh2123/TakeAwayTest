//
//  ArticleRequestTests.swift
//  NYTTests
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//


import XCTest
@testable import NYT

class ArticleRequestTests: XCTestCase {
    
    
    var articleRequest: ArticleRequest!
    var article: Article?
    
    override func setUp() {
        articleRequest = ArticleRequest()
    }
    
    override func tearDown() {
        articleRequest = nil
    }
    
    func testArticleRequestWithMockData() {
        articleRequest.getArticles(for: .emailed, { [weak self] (article) in
            self?.article = article

            }, failure: { (error) in }, useMockData: true)
        XCTAssertNotNil(article, "articles not present")
    }
}
