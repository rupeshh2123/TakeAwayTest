//
//  DashboardViewController.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 24/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    @IBOutlet private weak var dashboardTableView: UITableView!
    private var dashboardTableViewDataSource = DashboardTableViewDataSource()
    
    private func setUpUIComponents() {
        dashboardTableView.dataSource = dashboardTableViewDataSource
        dashboardTableView.delegate = dashboardTableViewDataSource
        dashboardTableViewDataSource.delegate = self
        dashboardTableView.estimatedRowHeight = 80
        dashboardTableView.rowHeight = UITableView.automaticDimension
        dashboardTableView.register(UINib(nibName: DashboardTableViewCell.xibName, bundle: nil), forCellReuseIdentifier: DashboardTableViewCell.reuseIdentifier)
        dashboardTableView.tableFooterView = UIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "NYT"
        setUpUIComponents()
        dashboardTableViewDataSource.buildRows()
    }
}

extension DashboardViewController: DashboardTableViewDataSourceDelegate{
    
    func navigateToArticleVC(type: PopularType) {
        let articleViewController = ArticleViewController()
        articleViewController.popularType = type
        navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    func navigateToMostSharedVC() {
        navigateToArticleVC(type: .shared)
    }
    
    func navigateToMostEmailedVC() {
        navigateToArticleVC(type: .emailed)
    }
    
    func navigateToMostViewedVC() {
        navigateToArticleVC(type: .viewed)
    }
    
    func reloadDashboardTableView() {
        dashboardTableView?.reloadData()
    }
}
