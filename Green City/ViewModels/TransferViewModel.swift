//
//  TransferViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TransferViewModel : NetworkResponseProtocol
{

    var transferView : TransferView!
    
    func checkCode(code : String)
    {
        if (code == "qwerty")
        {
            applyPayment()
        }
        else
        {
            transferView.showPaymentStatus(message: "Code was not valid!", title: "Code error")
        }
    }
   
    func applyPayment()
    {
        let userEmail : String = getCurrentUserEmail()
        let parameters : Parameters =
            [
                //"$class": "org.GreenCity.Wallet",
                "holderEmail" : String(userEmail),
                "balance" : 123.0,
                "lastUpdated" : DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short)
        ]
        Alamofire.SessionManager.default.request(WalletRouter.updateBalance(holderEmail: userEmail, parameters: parameters)).responseJSON {response in
            var message = ""
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        self.onSuccess(response: nil, option: nil)
                    case 401: break
                    case 422: break
                    case 500:
                        print(response.result.error)
                    default:
                        break
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
                self.onFailure(error: message, option: nil)
            }
            if (message != nil)
            {
                print(message)
            }
        }
    }
    func onSuccess(response: JSON, option: Int?) {
        print(response)
        transferView.showPaymentStatus(message: "Payment was successfull!", title: "Success")
    }
    
    func onFailure(error: String, option: Int?) {
        transferView.showPaymentStatus(message: "Payment was unsuccessful!", title: "Failure")
    }
    
    
    
}
