//
//  TransactionModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation


class TransactionModel
{
    var transactionID : String?
    var donatorName : String?
    var trasactionDate : String?
    
    init(trasID: String, donator : String, date: String) {
        self.transactionID = trasID
        self.donatorName = donator
        self.trasactionDate = date
    }
}
