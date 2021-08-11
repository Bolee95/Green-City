//
//  WalletStruct.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import ObjectMapper

class Wallet : Mappable
{
    var holderEmail : String?
    var balance : Double?
    var lastUpdated : String?
    
    
    init(holderEmail : String, balance : Double, lastUpdated : String)
    {
        self.holderEmail = holderEmail
        self.balance = balance
        self.lastUpdated = lastUpdated
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        holderEmail <- map["holderEmail"]
        balance <- map["balance"]
        lastUpdated <- map["lastUpdated"]
    }
}
