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
    func reloadArticleTableView() {
        articleTableView.reloadData()
    }

    func fetchArticles() {
        activityIndicatorView.startAnimating()
        ArticleRequest().getArticles(for: popularType, offset: 1, { [weak self] (article) in
            guard let weakSelf = self else { return }
            weakSelf.activityIndicatorView.stopAnimating()
            weakSelf.articleTableViewDataSource.article = article
            }, failure: {
                [weak self] (error) in
                guard let weakSelf = self else { return }
                weakSelf.activityIndicatorView.stopAnimating()
                ErrorHandler.showError(error: error, viewController: self!)
        })
    }

}
