//
//  ArticleTableViewDataSource.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Foundation
import UIKit

protocol ArticleTableViewDataSourceDelegate: class {
    func reloadArticleTableView()
    func fetchArticles()
}

class ArticleTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: ArticleTableViewDataSourceDelegate?
    private var sections = [NYTSection]()
    
    var article: Article? {
        didSet {
            if let model = article {
                buildArticleRows(for: model)
            }
        }
    }
    
    private func convertedDate(publishedDate: String) -> Date? {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withFullDate,
                                   .withTime,
                                   .withDashSeparatorInDate,
                                   .withColonSeparatorInTime]
        
        let convertedDate = formatter.date(from: publishedDate)
        return convertedDate
    }
    
    private func buildArticleRows(for model: Article) {
        var rows: [NYTRow] = []
        for result in model.results {
            let articleRow = NYTRow()
            let articleTableViewCellModel = ArticleTableViewCellModel(title: result.title, description: result.publishedDate)
            articleRow.data = articleTableViewCellModel
            articleRow.type = ArticleTableViewCell.self
            rows.append(articleRow)
        }
        sections.append(NYTSection(sectionTitle: "", rows: rows))
        delegate?.reloadArticleTableView()
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections.count > 0 {
            return sections[section].rows.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.model = (row.data as? ArticleTableViewCellModel)!
        return cell
    }
}







