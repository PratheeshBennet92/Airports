//
//  AirportsBussinessLayer.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import Foundation
import CoreLocation

struct AirportsBussinessLayer{
    static func searchAirpots(with text:String, among airports:[Airport]) -> [Airport]{
        return airports.filter { (eachAirport) -> Bool in
            eachAirport.name?.contains(text) ?? false
        }
    }
    static func getTheNearestFiveAiports(from airport:Airport, among airports:[Airport]) -> [NearestAirport]?{
        var nearestAirports = [NearestAirport]()
        guard
            let latString = airport.lat,
            let lonString = airport.lon,
            let currentLat = Double(latString),
            let currentLon = Double(lonString) else{
                return nil
        }
        airports.forEach { (eachAirport) in
            guard
                let latString = eachAirport.lat,
                let lonString = eachAirport.lon,
                let lat = Double(latString),
                let lon = Double(lonString) else{
                    return
            }
            let location = CLLocation(latitude: lat, longitude: lon)
            let currentLocation = CLLocation(latitude: currentLat, longitude: currentLon)
            let distance = location.distance(from: currentLocation)
            var nearestAiport = NearestAirport()
            nearestAiport.distance = distance
            nearestAiport.name = eachAirport.name
            nearestAiport.runwayLength = eachAirport.runway_length
            nearestAiport.country = eachAirport.country
            nearestAirports.append(nearestAiport)
        }
        var sortedAirports = nearestAirports.sorted { (airport1, airport2) -> Bool in
            guard
                let distance1 = airport1.distance,
                let distance2 = airport2.distance else{
                    return false
            }
            return distance1 < distance2
        }
        if sortedAirports.count > 0{
            sortedAirports = Array(sortedAirports.dropFirst())
        }
        print(sortedAirports)
        return sortedAirports
    }
}
