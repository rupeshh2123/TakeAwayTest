//
//  NYTSection.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 24/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Foundation

typealias VoidClosure = () -> Void

class NYTRow {
    var data: AnyObject?
    var type: AnyClass?
    var onTapAction: VoidClosure!
}

class NYTSection {
    var sectionTitle: String!
    var rows: [NYTRow]
    var rowCount = 0
    var accessibilityIdentifier = ""
    var data: AnyObject?
    init(sectionTitle: String!, rows: [NYTRow], data: AnyObject? = nil) {
        self.sectionTitle = sectionTitle
        self.rows = rows
        self.data = data
    }
}

