//
//  DashboardTableViewCell.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 8/12/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import UIKit

class DashboardTableViewCellModel {
    var title: String
    init(title: String) {
        self.title = title
    }
}


class DashboardTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    
      var model: DashboardTableViewCellModel? {
        didSet {
            if let model = model {
                titleLabel?.text = model.title
            }
        }
    }
   
    static var xibName: String {
        return String(describing: self.classForCoder())
    }

    class var reuseIdentifier: String {
        return String(describing: self.classForCoder())
    }
}
