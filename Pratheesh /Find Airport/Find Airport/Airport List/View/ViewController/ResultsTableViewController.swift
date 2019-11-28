//
//  ResultsTableViewController.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import UIKit
protocol NavigateToDetailDelegate: AnyObject {
    func navigateToDetaiScreen(with airports: [Airport], for indexPath:IndexPath)
}

// MARK: - UITableViewDelegate
extension ResultsTableViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return instantiateCell(for: indexPath, with: airports[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailDelegate?.navigateToDetaiScreen(with: airports, for: indexPath)
    }
}

// MARK: - UITableViewDataSource
extension ResultsTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return defaultNumberOfSections
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
}
class ResultsTableViewController: BaseViewController {
    // MARK: - Propery Declaration
    var airports = [Airport]()
    weak var navigateToDetailDelegate: NavigateToDetailDelegate?
    
    // MARK: - Life Cycle Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
