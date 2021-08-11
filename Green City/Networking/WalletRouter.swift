//
//  WalletRouter.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/24/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Alamofire

enum WalletRouter: URLRequestConvertible {
    case createWallet(parameters: Parameters) //body
    case getWallets()
    case getWalletById(holderEmail: String) //path
    case checkWalletExists(holderEmail : String) //path
    case updateBalance(holderEmail: String, parameters: Parameters) //holder path i novi parametri
    
    var method : HTTPMethod{
        switch self {
        case .createWallet:
            return .post
        case .getWallets,
             .getWalletById:
            return .get
        case .checkWalletExists:
            return .head
        case .updateBalance:
            return .put
        
        }
    }
    
    //nema patha, svi su isti, definisano preko walletNamespaceString
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        
        var urlRequest = URLRequest(url : url.appendingPathComponent(walletNamespaceString))
        print(method.rawValue)
        urlRequest.httpMethod = method.rawValue
        
        switch self{
        case
        .createWallet(let parameters):
            do{
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
        case
        .getWalletById(let holderEmail),
        .checkWalletExists(let holderEmail):
            do{
                urlRequest = URLRequest(url : urlRequest.url!.appendingPathComponent(holderEmail))
            }
        case
        .updateBalance(let holderEmail,let parameters):
            do{
                print(parameters)
                urlRequest = try JSONEncoding.default.encode(urlRequest,with : parameters)
                urlRequest = URLRequest(url : urlRequest.url!.appendingPathComponent(holderEmail))
            }
        default:
            break
            
        }
        print(urlRequest)
        return urlRequest
    }
}
