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
    func onbuildRowsCompleted()
    func fetchArticles()
    func navigateToArticleDetailVC(articleResult: ArticleResult)
}

class ArticleTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: ArticleTableViewDataSourceDelegate?
    var totalCount: Int = 0
    var rows: [NYTRow] = []
    var isOfflineMode: Bool = false
    
    var articleResult: [ArticleResult] = [] {
        didSet {
            buildArticleRows(for: articleResult)
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
    
    private func buildArticleRows(for articleResult: [ArticleResult]) {
        for result in articleResult {
            let articleRow = NYTRow()
            let articleTableViewCellModel = ArticleTableViewCellModel(title: result.title, description: result.publishedDate)
            articleRow.data = articleTableViewCellModel
            articleRow.type = ArticleTableViewCell.self
            rows.append(articleRow)
        }
        self.delegate?.onbuildRowsCompleted()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleTableViewCell.reuseIdentifier, for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        cell.model = (row.data as? ArticleTableViewCellModel)!
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard !isOfflineMode else { return }
        if indexPath.row == articleResult.count - 1 {
            if articleResult.count < totalCount {
                delegate?.fetchArticles()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.navigateToArticleDetailVC(articleResult: articleResult[indexPath.row])
    }
}







