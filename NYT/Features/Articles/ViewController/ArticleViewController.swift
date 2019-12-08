//
//  ArticleViewController.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 25/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import UIKit

class ArticleViewController: UIViewController {

    @IBOutlet private weak var articleTableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    private var articleTableViewDataSource = ArticleTableViewDataSource()
    var popularType: PopularType = .emailed
    var offset = 0
    var isFetchInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Articles"
        setUpUIComponents()
        fetchArticles()
    }

    

    private func setUpUIComponents() {
        activityIndicatorView.hidesWhenStopped = true
        articleTableView?.dataSource = articleTableViewDataSource
        articleTableView?.delegate = articleTableViewDataSource
        articleTableViewDataSource.delegate = self
        articleTableView.rowHeight = UITableView.automaticDimension
        articleTableView.estimatedRowHeight = UITableView.automaticDimension
        articleTableView?.register(UINib(nibName: ArticleTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: ArticleTableViewCell.reuseIdentifier)
        articleTableView?.tableFooterView = UIView()
    }
    
}

extension ArticleViewController: ArticleTableViewDataSourceDelegate {
    
     func onbuildRowsCompleted(with newIndexPathsToReload: [IndexPath]?) {
       // 1
       guard let newIndexPathsToReload = newIndexPathsToReload else {
         articleTableView.isHidden = false
         articleTableView.reloadData()
         return
       }
       articleTableView.reloadData()
     }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
      let indexPathsForVisibleRows = articleTableView.indexPathsForVisibleRows ?? []
      let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
      return Array(indexPathsIntersection)
    }
    
    func fetchArticles() {
        guard !isFetchInProgress else { return }
        isFetchInProgress = true
        activityIndicatorView.startAnimating()
        ArticleRequest().getArticles(for: popularType, offset: offset, { [weak self] (article) in
            guard let weakSelf = self else { return }
            weakSelf.activityIndicatorView.stopAnimating()
            weakSelf.articleTableViewDataSource.totalCount = article.count ?? 0
            weakSelf.articleTableViewDataSource.articleResult = article.results
            weakSelf.isFetchInProgress = false
            weakSelf.offset = weakSelf.offset + 20
            }, failure: {
                [weak self] (error) in
                guard let weakSelf = self else { return }
                weakSelf.isFetchInProgress = false
                weakSelf.activityIndicatorView.stopAnimating()
                ErrorHandler.showError(error: error, viewController: self!)
        })
    }
    
}
