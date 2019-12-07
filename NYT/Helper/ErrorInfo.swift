//
//  ErrorInfo.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Foundation

class ErrorInfo: Error {
    var title: String
    var statusCode: Int
    var code: Int
    var description: String
    init(title: String, statusCode: Int, code: Int, description: String) {
        self.title = title
        self.statusCode = statusCode
        self.code = code
        self.description = description
    }
}
