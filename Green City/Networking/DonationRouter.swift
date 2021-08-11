//
//  DonationRouter.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/24/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Alamofire

enum DonationRouter: URLRequestConvertible {
    case makeDonation(parameters: Parameters) //body
    case getAllDonations()
    case getDonationById(transactionId: String) //path
    
    var method : HTTPMethod{
        switch self {
        case .makeDonation:
            return .post
        case .getAllDonations,
             .getDonationById:
            return .get
       
        }
    }
    
    //nema patha, svi su isti, definisano preko donationNamespaceString
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        
        var urlRequest = URLRequest(url : url.appendingPathComponent(donationNamespaceString))
        urlRequest.httpMethod = method.rawValue
        
        switch self{
        case
        .makeDonation(let parameters):
            do{
                urlRequest = try JSONEncoding.default.encode(urlRequest, with: parameters)
            }
        case
        .getDonationById(let name):
            do{
                urlRequest = URLRequest(url : urlRequest.url!.appendingPathComponent(name))
            }
        default:
            break
            
        }
        return urlRequest
    }
}
