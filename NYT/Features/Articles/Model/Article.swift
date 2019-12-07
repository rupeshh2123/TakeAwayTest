//
//  Article.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Foundation

class Article: Decodable {
    var count : Int?
    var results: [ArticleResult]

    private enum CodingKeys: String, CodingKey {
        case results
        case count = "num_results"
    }
}

class ArticleResult: Decodable {
    var title: String?
    var publishedDate: String?
    
    private enum CodingKeys: String, CodingKey {
        case title
        case publishedDate = "published_date"
    }
}
