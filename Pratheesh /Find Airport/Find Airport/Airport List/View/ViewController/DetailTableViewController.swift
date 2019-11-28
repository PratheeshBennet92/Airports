//
//  DetailTableViewController.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import UIKit
// MARK: - Table view delegate
extension DetailTableViewController{
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return selectedAirport
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(headerHeight)
    }
}

// MARK: - Table view data source
extension DetailTableViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
           return defaultNumberOfSections
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nearestAirports.count > numberOfNearestAirport ? numberOfNearestAirport : nearestAirports.count
       }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as? DetailTableViewCell ?? DetailTableViewCell()
        cell.selectionStyle = .none
        cell.airport = nearestAirports[indexPath.row]
        return cell
    }
}

class DetailTableViewController: BaseViewController {
    // MARK: - Propery Declaration
    var nearestAirports = [NearestAirport]()
    var selectedAirport: String?
    
    // MARK: - Life Cycle Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    // MARK: - UISetup
    private func setUpView(){
    tableView.register(UINib(nibName: detailTableViewCell, bundle: nil), forCellReuseIdentifier: detailCellIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CGFloat(estimatedRowHeight)
    }
}
