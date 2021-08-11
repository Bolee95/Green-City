//
//  ActionRouter.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/24/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Alamofire

enum ActionRouter: URLRequestConvertible {
    case addAction(parameters: Parameters) //body
    case getActions()
    case getActionById(name: String) //path
    case checkActionExists(name : String) //path
    
    var method : HTTPMethod{
        switch self {
        case .addAction:
            return .post
        case .getActions,
             .getActionById:
            return .get
        case .checkActionExists:
            return .head
        }
    }
    
    //nema patha, svi su isti, definisano preko actionNamespaceString
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        
        var urlRequest = URLRequest(url : url.appendingPathComponent(actionNamespaceString))
        urlRequest.httpMethod = method.rawValue
        
        switch self{
        case
        .addAction(let parameters):
            do{
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
        case
        .getActionById(let name),
        .checkActionExists(let name):
            do{
                urlRequest = URLRequest(url : urlRequest.url!.appendingPathComponent(name))
            }
        default:
            break
            
        }
        return urlRequest
    }
}
