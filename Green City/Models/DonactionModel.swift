//
//  DonactionStruct.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import ObjectMapper

class DonationModel : Mappable
{
    var date : String? //probati sa Date klasom
    var ammount : Double?
    var actionName : String? //da olaksamo malo, nije potrebna nikakva refenca
    var transactionID : String?//sluzi da se prepozna transakcija u listi transakcija
    var contributorEmail: String?
    
    //pomocna promenjiva, nema je u bazi
    var isUserDonation : Bool = false
    
    init(date : String, ammount : Double, actionName : String, transactionID : String, contributorEmail : String) {
        self.date = date
        self.ammount = ammount
        self.actionName = actionName
        self.transactionID = transactionID
        self.contributorEmail = contributorEmail
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map)
    {
        date <- map["date"]
        ammount <- map["ammount"]
        actionName <- map["action"] //resource:org.GreenCity.Action# ovo da se skrati i dobija se ime
        transactionID <- map["transactionId"]
        contributorEmail <- map["user"] //resource:org.GreenCity.User# se skrati i dobija se email
        
    }
}
