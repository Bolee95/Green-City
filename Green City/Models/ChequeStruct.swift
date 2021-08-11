//
//  ChequeStruct.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import ObjectMapper

struct Cheque : Mappable {
    var contributorEmail : String
    var ammount : Double
    
    init(contributorEmail: String, ammount : Double) {
        self.contributorEmail = contributorEmail
        self.ammount = ammount
    }
    
    
    init?(map: Map) {
        self.contributorEmail = ""
        self.ammount = 0
    }
    
    mutating func mapping(map: Map) {
        self.contributorEmail <- map["contributorEmail"]
        self.ammount <- map["ammount"]
    }
}
