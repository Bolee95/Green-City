//
//  DonationViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/21/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire


class DonationViewModel
{
    var donationView : DonationView!
    
    func performTransaction(actionName : String, donatorEmail: String, ammount: Double)
    {
        let user = "resource:org.GreenCity.User#" + donatorEmail
        let action = "resource:org.GreenCity.Action#" + actionName
        
        let parameters : Parameters =
            [
                "ammount" : ammount,
                "user" : user,
                "action" : action,
                "date" : Date().iso8601  //"2018-09-20T13:48:00.434Z"//DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .long, timeStyle: .long)
        ]
        
        Alamofire.SessionManager.default.request(DonationRouter.makeDonation(parameters: parameters)).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        self.donationView.showTransactionStatus(message: "Transaction was successful!", title: "Success")
                    case 401,422,400,500:
                        print(response.result.debugDescription)
                         self.donationView.showTransactionStatus(message: "Transaction was unsuccessful!", title: "Failure")
                        break
                    default:
                        break
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
                print(message)
                self.donationView.showTransactionStatus(message: message!, title: "Failure")
            }
        }
        
    }
    
    
}
