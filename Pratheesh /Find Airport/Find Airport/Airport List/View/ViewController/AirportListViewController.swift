//
//  AirportListViewController.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import UIKit
// MARK: - NavigateToDetailDelegate
extension AirportListViewController: NavigateToDetailDelegate{
    func navigateToDetaiScreen(with airports: [Airport], for indexPath: IndexPath) {
        navigateToDetailView(with: airportsCopy, for: airports[indexPath.row])
    }
}

// MARK: - UISearchResultsUpdating
extension AirportListViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text, searchText != emptyString {
            let filteredAirports = AirportsBussinessLayer.searchAirpots(with: searchText, among: airports)
            if let resultsController = searchController.searchResultsController as? ResultsTableViewController {
                resultsController.airports = filteredAirports
                resultsController.tableView.reloadData()
            }
        }
    }
}

// MARK: - UISearchControllerDelegate
extension AirportListViewController: UISearchControllerDelegate{
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return true
    }
}

// MARK: - UITableViewDelegate
extension AirportListViewController{
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return instantiateCell(for: indexPath, with: airports[indexPath.row])
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailView(with: airports, for: airports[indexPath.row])
    }
}

// MARK: - UITableViewDataSource
extension AirportListViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return defaultNumberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return airports.count
    }
}

// MARK: - AirportsViewModelDelegate
extension AirportListViewController: AirportsViewModelDelegate{
    func passFetchedAirports(_ airPorts: [Airport]?) {
        if let airportsFromAPI = airPorts{
            airports = airportsFromAPI
            airportsCopy = airports
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
        }else{
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.showErrorAlert()
            }
        }
    }
}

class AirportListViewController: BaseViewController {
    // MARK: - Propery Declaration
    private var searchController: UISearchController!
    private var resultsController: ResultsTableViewController!
    private var airports = [Airport]()
    private var airportsCopy = [Airport]()
    private var viewModel = AirportListViewModel()
    private var activityIndicator = ActivityIndicator()
    
    // MARK: - Life Cycle Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityIndicator.displaySpinner(onView: UIApplication.shared.windows.filter {$0.isKeyWindow}.first!, title: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.delegate = self
        viewModel.fetchAirports()
    }
    
    // MARK: - UISetup
    private func setUpView(){
        resultsController = ResultsTableViewController()
        resultsController.navigateToDetailDelegate = self
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = searchAirports
        definesPresentationContext = true
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            tableView.tableHeaderView = searchController.searchBar
        }
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = airportsString
        navigationItem.largeTitleDisplayMode = .always
    }
    func showErrorAlert() {
        let alert = UIAlertController(title: errorString, message: errorMessage,         preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: retryString, style: UIAlertAction.Style.default, handler: { _ in
            self.activityIndicator.displaySpinner(onView: UIApplication.shared.windows.filter {$0.isKeyWindow}.first!, title: nil)
            self.viewModel.fetchAirports()
        }))
        alert.addAction(UIAlertAction(title: okString,
                                      style: UIAlertAction.Style.cancel,
                                      handler: {(_: UIAlertAction!) in
                                        
        }))
        self.present(alert, animated: true, completion: nil)
    }  
}
