//
//  AirportsDataStore.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import Foundation
protocol DataStore {
    func fetchAirports()
}
class AirportsDataStore: DataStore {
    typealias ResponseClosure = ([Airport]) -> Void
    typealias ErrorClosure = (Error) -> Void
    var responseClosure: ResponseClosure?
    var errorClosure: ErrorClosure?
    func fetchAirports() {
        let airportRequest = AirportRequest()
        airportRequest.url = airportUrl
        airportRequest.httpMethod = .get
        airportRequest.requestTimeOut = Double(requestTimeOut)
        airportRequest.cachePolicy = .reloadIgnoringLocalCacheData
        let networkHandler = NetworkHandler<Airport>.shared
        networkHandler.airportRequest = airportRequest
        do {
            try networkHandler.downloadData(onCompletion: { [weak self](airports) in
                self?.responseClosure?(airports)
                }, failure: { [weak self](error) in
                    self?.errorClosure?(error)
            })
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
