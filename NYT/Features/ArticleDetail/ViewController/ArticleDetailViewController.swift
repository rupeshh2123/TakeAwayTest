//
//  ArticleDetailViewController.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 08/12/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    var articleResult: ArticleResult?
    
    @IBOutlet private weak var publishedDateLabel: UILabel!
    @IBOutlet private weak var sourceLabel: UILabel!
    @IBOutlet private weak var abstractLabel: UILabel!
    @IBOutlet private weak var bylineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let articleResult = self.articleResult else { return }
        title = articleResult.title ?? ""
        publishedDateLabel.text = articleResult.publishedDate ?? ""
        sourceLabel.text = articleResult.source ?? ""
        abstractLabel.text = articleResult.source ?? ""
        bylineLabel.text = articleResult.byline ?? ""
    }
}
