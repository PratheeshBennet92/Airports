//
//  AirportRequest.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import Foundation
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}
protocol BaseRequest {
    var url: String? { get }
    var httpMethod: HTTPMethod? { get }
    var requestTimeOut: Double? { get }
    var cachePolicy: NSURLRequest.CachePolicy? { get }
}
class AirportRequest: BaseRequest {
    var cachePolicy: NSURLRequest.CachePolicy?
    var requestTimeOut: Double?
    var httpMethod: HTTPMethod?
    var url: String?
}
