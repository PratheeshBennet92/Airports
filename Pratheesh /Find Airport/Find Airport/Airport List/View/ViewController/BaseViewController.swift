//
//  BaseViewController.swift
//  Find Airport
//
//  Created by 1722885 on 29/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import UIKit

class BaseViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CGFloat(estimatedRowHeight)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    func instantiateCell(for indexPath: IndexPath, with airport: Airport) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = airport.name
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        return cell
    }
    func navigateToDetailView(with airports: [Airport], for selectedAirport:Airport){
        let detailVC = DetailTableViewController()
        detailVC.selectedAirport = selectedAirport.name
        let nearestFiveAirports = AirportsBussinessLayer.getTheNearestFiveAiports(from: selectedAirport, among: airports)
        detailVC.nearestAirports = nearestFiveAirports ?? [NearestAirport]()
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
