//
//  ArticleViewController.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 8/12/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import UIKit
import CoreData

class ArticleViewController: UIViewController {

    @IBOutlet private weak var articleTableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    private var articleTableViewDataSource = ArticleTableViewDataSource()
    var popularType: PopularType = .emailed
    var offset = 0
    var isFetchInProgress = false
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var articleData: [ArticleData] = []
    
    var popularTypeString: String {
      if popularType == .emailed { return "Most Emailed" }
        else if popularType == .shared {
            return "Most Shared"
        } else {
            return  "Most Viewed"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = popularTypeString
        setUpUIComponents()
        fetchArticleFromDB()
        articleData.isEmpty ? fetchArticles() : buidRowsFromArticleData()
    }
    
    func fetchArticleFromDB() {
        let request = ArticleData.fetchRequest() as NSFetchRequest<ArticleData>
        request.predicate = NSPredicate(format: "type CONTAINS[cd] %@", popularTypeString)
        do {
          articleData = try context.fetch(request)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    private func buidRowsFromArticleData() {
        var results: [ArticleResult] = []
        for (_, element) in articleData.enumerated() {
            let article = ArticleResult()
            article.abstract = element.abstract
            article.byline = element.byline
            article.source = element.source
            article.publishedDate = element.publishedDate
            article.title = element.title
            results.append(article)
        }
        articleTableViewDataSource.isOfflineMode = true
        articleTableViewDataSource.articleResult = results
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
    
    private func saveArticles(articleResults: [ArticleResult]) {
        for articleResult in articleResults {
            let article = ArticleData(entity: ArticleData.entity(), insertInto: context)
            article.title = articleResult.title ?? ""
            article.publishedDate = articleResult.publishedDate ?? ""
            article.source = articleResult.source ?? ""
            article.abstract = articleResult.abstract ?? ""
            article.byline = articleResult.byline ?? ""
            article.type = popularTypeString
            appDelegate.saveContext()
        }
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
            weakSelf.saveArticles(articleResults: article.results)
            }, failure: {
                [weak self] (error) in
                guard let weakSelf = self else { return }
                weakSelf.isFetchInProgress = false
                weakSelf.activityIndicatorView.stopAnimating()
                ErrorHandler.showError(error: error, viewController: self!)
        })
    }
}
