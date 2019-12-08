//
//  DateExtension.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 8/12/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Foundation

extension Date
{
    func toString( dateFormat format  : String ) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
