//
//  DashboardTableViewDataSource.swift
//  NYT
//
//  Created by Rupesh Jaiswal on 24/07/19.
//  Copyright © 2019 Rupesh Jaiswal. All rights reserved.
//

import Foundation
import UIKit

protocol DashboardTableViewDataSourceDelegate: class {
    func reloadDashboardTableView()
    func navigateToMostSharedVC()
    func navigateToMostEmailedVC()
    func navigateToMostViewedVC()
 }

class DashboardTableViewDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    weak var delegate: DashboardTableViewDataSourceDelegate?
    private var sections = [NYTSection]()

     func buildRows() {
        
        let mostViewedRow = NYTRow()
        let mostViewedTableViewCellModel = DashboardTableViewCellModel(title: "Most Viewed")
        mostViewedRow.data = mostViewedTableViewCellModel
        mostViewedRow.type = DashboardTableViewCell.self
        mostViewedRow.onTapAction = delegate?.navigateToMostViewedVC
        let mostSharedRow = NYTRow()
        let mostSharedTableViewCellModel = DashboardTableViewCellModel(title: "Most Shared")
        mostSharedRow.data = mostSharedTableViewCellModel
        mostSharedRow.type = DashboardTableViewCell.self
        mostSharedRow.onTapAction = delegate?.navigateToMostSharedVC

        let mostEmailedRow = NYTRow()
        let mostEmailedTableViewCellModel = DashboardTableViewCellModel(title: "Most Emailed")
        mostEmailedRow.data = mostEmailedTableViewCellModel
        mostEmailedRow.type = DashboardTableViewCell.self
        mostEmailedRow.onTapAction = delegate?.navigateToMostEmailedVC

        sections.append(NYTSection(sectionTitle: "Popular", rows: [mostViewedRow, mostSharedRow, mostEmailedRow]))
        delegate?.reloadDashboardTableView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].sectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = sections[indexPath.section].rows[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DashboardTableViewCell.reuseIdentifier, for: indexPath) as? DashboardTableViewCell else {
            return UITableViewCell()
        }
        cell.model = (row.data as? DashboardTableViewCellModel)!
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard let onTapAction = sections[indexPath.section].rows[indexPath.row].onTapAction  else {
            return
        }
        onTapAction()
    }
}
