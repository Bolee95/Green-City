//
//  UserRouter.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Alamofire

enum UserRouter: URLRequestConvertible {
    case addUser(parameters: Parameters) //body
    case getUsers()
    case getUserById(email: String) //path
    case checkUserExists(email : String) //path
    
    var method : HTTPMethod{
        switch self {
        case .addUser:
            return .post
        case .getUsers,
             .getUserById:
            return .get
        case .checkUserExists:
            return .head
        }
    }
    
    //nema patha, svi su isti, definisano preko userNamespaceString
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        
        var urlRequest = URLRequest(url : url.appendingPathComponent(userNamespaceString))
        urlRequest.httpMethod = method.rawValue
        
        switch self{
            case
            .addUser(let parameters):
                do{
                    urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
             case
             .getUserById(let email),
             .checkUserExists(let email):
                do{
                    urlRequest = URLRequest(url : urlRequest.url!.appendingPathComponent(email))
            }
        default:
            break
            
        }
        return urlRequest
    }
}
