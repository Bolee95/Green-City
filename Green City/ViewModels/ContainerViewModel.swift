//
//  ContainerViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/17/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ContainerViewModel : NetworkResponseProtocol
{
    var containerView : ContainerView!
    
    func updateBalance()
    {
       let email = getCurrentUserEmail() as String
        Alamofire.SessionManager.default.request(WalletRouter.getWalletById(holderEmail: email)).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        let jsonVar = JSON(response.result.value!)
                        self.onSuccess(response: jsonVar,option: nil)
                        
                    case 401:
                        print(response.result.debugDescription)
                    case 422:
                        print(response.result.debugDescription)
                    case 400:
                        print(response.result.debugDescription)
                    case 500:
                        print(response.result.debugDescription)
                    default:
                        break
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
            }
            if (message != nil)
            {
                print(message!)
            }
        }
    }
    
    func onSuccess(response: JSON, option: Int?) {
        let wallet = Wallet(JSONString: response.rawString()!)
        containerView.balanceField.text = String(format: "%.2f", (wallet?.balance!)!) + "$"
    }
    
    func onFailure(error: String, option: Int?) {
        print(error)
    }
}
