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
    func onbuildRowsCompleted(with newIndexPathsToReload: [IndexPath]?)
    func fetchArticles()
}

class ArticleTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var delegate: ArticleTableViewDataSourceDelegate?
    var totalCount: Int = 0
    var rows: [NYTRow] = []
    
    
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
        rows.append(contentsOf: rows)
        if rows.count > 20 {
          let indexPathsToReload = self.calculateIndexPathsToReload(from: articleResult)
          self.delegate?.onbuildRowsCompleted(with: indexPathsToReload)
        } else {
          self.delegate?.onbuildRowsCompleted(with: .none)
        }
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
        if indexPath.row == articleResult.count - 1 {
            if articleResult.count < totalCount {
                delegate?.fetchArticles()
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newArticleResult: [ArticleResult]) -> [IndexPath] {
      let startIndex = rows.count - newArticleResult.count
      let endIndex = startIndex + newArticleResult.count
      return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}







