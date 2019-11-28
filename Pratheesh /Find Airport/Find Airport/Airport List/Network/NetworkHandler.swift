//
//  NetworkHandler.swift
//  Find Airport
//
//  Created by 1722885 on 28/11/19.
//  Copyright © 2019 tcs. All rights reserved.
//

import Foundation
enum AirportError: Error{
    case NetworkError
}

class NetworkHandler<T>: NSObject where T: Codable{
    // MARK: - Propery Declaration
    static var shared: NetworkHandler<T>{
        return NetworkHandler<T>()
    }
    typealias ResponseClosure = ([T]) -> Void
    typealias ErrorClosure = (Error) -> Void
    var airportRequest: AirportRequest?
    typealias ResponseObjectType = T
    private var sessionConfiguration: URLSessionConfiguration{
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.isDiscretionary = true
        sessionConfig.allowsCellularAccess = true
        return sessionConfig
    }
    private var urlSession: URLSession{
        return URLSession(configuration: sessionConfiguration)
    }
    
    // MARK: - API Call
    func downloadData(onCompletion success: @escaping ResponseClosure, failure:@escaping ErrorClosure) throws{
        guard
            let timeOutSeconds = airportRequest?.requestTimeOut,
            let httpMethod = airportRequest?.httpMethod,
            let urlString = airportRequest?.url,
            let url = URL(string: urlString),
            let cachePolicy = airportRequest?.cachePolicy else{
                throw AirportError.NetworkError
        }
        var urlRequest = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeOutSeconds)
        urlRequest.httpMethod = httpMethod.rawValue
        urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let errorResponse = error{
                failure(errorResponse)
            }else{
                do{
                    if  let dataResponse = data,
                        let jsonString = String(data: dataResponse, encoding: .utf8){
                        print(jsonString)
                        let jsonData = jsonString.data(using: .utf8)!
                        let decoder = JSONDecoder()
                        let responseObject = try decoder.decode([ResponseObjectType].self, from: jsonData)
                        success(responseObject)
                    }
                }
                catch let error{
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
}
