//
//  AirportViewModel.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//
protocol AirportsViewModelDelegate: class {
    func passFetchedAirports(_ airPorts:[Airport]?)
}
import Foundation
class AirportListViewModel{
    weak var delegate: AirportsViewModelDelegate?
    var airportsDataStore = AirportsDataStore()
    func fetchAirports(){
        airportsDataStore.responseClosure = {[weak self](airports) in
            self?.delegate?.passFetchedAirports(airports.filter({ (eachAirport) -> Bool in
                eachAirport.name != emptyString
            }))
        }
        airportsDataStore.errorClosure = {[weak self](error) in
            self?.delegate?.passFetchedAirports(nil)
        }
        airportsDataStore.fetchAirports()
    }
}
