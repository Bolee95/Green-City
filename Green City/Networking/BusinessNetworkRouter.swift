//
//  BusinessNetworkRouter.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/24/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Alamofire

enum BusinessNetworkRouter: URLRequestConvertible
{
    case pingNetwork()
    case getHistory()
    case getHistoryById(transactionId : String)
    
    var method : HTTPMethod{
        switch self {
        case .getHistory,
             .pingNetwork,
             .getHistoryById:
            return .get
        }
    }
    
    var path : String {
        switch self {
        case .pingNetwork:
            return pingNetworkString
        case .getHistory,
             .getHistoryById:
            return historianNetworkString

        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        
        var urlRequest = URLRequest(url : url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        switch self{
        case
       
        .getHistoryById(let transactionId):
            do{
                urlRequest = URLRequest(url : urlRequest.url!.appendingPathComponent(transactionId))
            }
        default:
            break
            
        }
        return urlRequest

}
}
