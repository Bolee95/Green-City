//
//  ActionViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/17/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ActionViewModel : NetworkResponseProtocol
{    
    weak var actionView : ActionView!
    var actions = [ActionModel]()
    var wallets = [String : Wallet]()
    var filteredActions = [ActionModel]()
    
    func filter(text: String)
    {
        if (text != "")
        {
            
            filteredActions = actions.filter {
                $0.name!.contains(text) != false
            }
        }
        else
        {
            filteredActions = actions
        }
        
        actionView.actionsTableView.reloadData()
    }
    
    func getWallets()
    {
        Alamofire.SessionManager.default.request(WalletRouter.getWallets()).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        let jsonVar = JSON(response.result.value!)
                        self.onSuccess(response: jsonVar,option: 2)
                        
                    case 401,422,400,500:
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
    
    
    func loadActions()
    {
        Alamofire.SessionManager.default.request(ActionRouter.getActions()).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        let jsonVar = JSON(response.result.value!)
                        self.onSuccess(response: jsonVar,option: 1)
                        
                    case 401,422,400,500:
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
        switch option {
        case 1:
            let arrayOfActions = response.arrayValue
            for action in arrayOfActions
            {
                let address = Address(JSONString: action["address"].rawString()!)
                let temp = ActionModel(JSONString: action.rawString()!)
                temp?.address = address
                actions.append(temp!)
            }
            filteredActions = actions
            self.getWallets()
            
        case 2:
            let arrayOfWallets = response.arrayValue
            for wallet in arrayOfWallets
            {
                let temp = Wallet(JSONString: wallet.rawString()!)
                wallets[temp!.holderEmail!] = temp!
            }
            actionView.actionsTableView.reloadData()
        default:
            break
        }
    }
    
    func onFailure(error: String, option: Int?) {
    
    }
}
