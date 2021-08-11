//
//  UserModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel : Mappable
{
    var firstName : String?
    var lastName : String?
    var email : String?
    var address : Address?
    var totalDonated : Double?
    var profileType : profileType?
    var donations = [Donation]()
    //var wallet : Wallet
    
    init(firstName : String, lastName : String, email : String, address : Address) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.address = address
        self.totalDonated = 0
        self.profileType = .GREENIE
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        firstName <- map["firstName"]
        lastName <- map["lastName"]
        email <- map["email"]
        address!.country <- map["address.country"]
        address!.city <- map["address.city"]
        address!.zip <- map["address.zip"]
        address!.zip <- map["address.street"]
        totalDonated <- map["totalDonated"]
    }
}
