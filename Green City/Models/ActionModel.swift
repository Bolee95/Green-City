//
//  ActionModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import ObjectMapper

class ActionModel : Mappable
{
    var organizerEmail : String?
    var name : String?
    var longitude : Double?
    var latitude : Double?
    var address : Address?
    var description : String?
    var moneyNeeded : Double?
    var status : Status?
    var date : String?
    var completed : Bool?
    var cotributors = [Cheque]()
    
    init(orgEmail: String, name : String, longitude : Double, latitude: Double, address: Address, desc : String, moneyNeeded : Double, date: String)
    {
        self.organizerEmail = orgEmail
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
        self.address = address
        self.description = desc
        self.moneyNeeded = moneyNeeded
        self.date = date
        self.status = .STARTED
        self.completed = false
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        organizerEmail <- map["organiserEmail"]
        name <- map["name"]
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        description <- map["description"]
        moneyNeeded <- map["moneyNeeded"]
        date <- map["date"]
        completed <- map ["completed"]
    }
}


