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
        if popularType == .emailed { title = "Most Emailed Articles" }
        else if popularType == .shared {
            title = "Most Shared Articles"
        } else {
            title = "Most Viewed Articles"
        }
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
    func navigateToArticleDetailVC(articleResult: ArticleResult) {
        let articleDetailViewController = ArticleDetailViewController()
        articleDetailViewController.articleResult = articleResult
        navigationController?.pushViewController(articleDetailViewController, animated: true)
    }

     func onbuildRowsCompleted() {
        articleTableView.reloadData()
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
