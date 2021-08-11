//
//  AddressStruct.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import ObjectMapper

struct Address : Codable,Mappable
{
    var city : String
    var country : String
    var street : String?
    var zip : String?
    
    init(city: String, country: String, street: String, zip: String) {
        self.city = city
        self.country = country
        self.street = street
        self.zip = zip
    }
    
    init?(map: Map) {
        self.city = ""
        self.country = ""
    }
    
    mutating func mapping(map: Map) {
        self.city <- map["city"]
        self.country <- map["country"]
        self.street <- map["street"]
        self.zip <- map["zip"]
    }
}
