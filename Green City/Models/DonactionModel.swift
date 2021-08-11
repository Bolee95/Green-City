//
//  DonactionStruct.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation

//treba struct
class Donation {
    var date : NSDate
    var ammount : Double
    var actionName : String //da olaksamo malo, nije potrebna nikakva refenca
    var transactionID : String //sluzi da se prepozna transakcija u listi transakcija
}
