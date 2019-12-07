//
//  ArticleTableViewCell.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import UIKit

class ArticleTableViewCellModel {
    var title: String?
    var description: String?
    
    init(title: String?, description: String?) {
      self.title = title
      self.description = description
    }
}

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    var model: ArticleTableViewCellModel? {
        didSet {
            if let model = model {
                updateUI(model: model)
            }
        }
    }
    
    private func updateUI(model: ArticleTableViewCellModel) {
        titleLabel?.text = model.title ?? ""
        descriptionLabel?.text = model.description ?? ""
    }
    
    static var xibName: String {
        return String(describing: self.classForCoder())
    }
    
    class var reuseIdentifier: String {
        return String(describing: self.classForCoder())
    }
    
}
