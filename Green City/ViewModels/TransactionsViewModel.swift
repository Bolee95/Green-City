//
//  TransactionsViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TransactionsViewModel : NetworkResponseProtocol
{
    var transactions = [DonationModel]()
    var actions = [String]()
    
    var transactionsView : TransactionsView!
    
    func getActionsDonations()
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
                        self.onSuccess(response: jsonVar,option: 3)
                        
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
    
    func getUserDonations()
    {
        Alamofire.SessionManager.default.request(UserRouter.getUserById(email: getCurrentUserEmail())).responseJSON {response in
            var message = ""
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        //self.createNewUser(user: user, password: password)
                        let swiftyJsonVar = JSON(response.result.value!)
                        self.onSuccess(response: swiftyJsonVar, option: 1)
                    case 401: break
                    //self.onError(error: "You are not authorized to perform this action!", option: 0)
                    case 422: break
                    //self.onError(error: "Action could not be performed. Please, try later.", option: 0)
                    case 500:
                        print(response.result.error)
                    default:
                        break
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
            }
            if (message != nil)
            {
                print(message)
            }
        }
    }
    
    func getDonationsToUserActions()
    {
        Alamofire.SessionManager.default.request(DonationRouter.getAllDonations()).responseJSON {response in
            var message = ""
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        //self.createNewUser(user: user, password: password)
                        let swiftyJsonVar = JSON(response.result.value!)
                        self.onSuccess(response: swiftyJsonVar, option: 2)
                    case 401: break
                    //self.onError(error: "You are not authorized to perform this action!", option: 0)
                    case 422: break
                    //self.onError(error: "Action could not be performed. Please, try later.", option: 0)
                    case 500:
                        print(response.result.error)
                    default:
                        break
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
            }
            if (message != nil)
            {
                print(message)
            }
        }
    }
    
    func onSuccess(response: JSON, option: Int?) {
        print(response)
        if option == 2
        {
            let arrayOfDonations = response.arrayValue
            for donation in arrayOfDonations
            {
                let temp = DonationModel(JSONString: donation.rawString()!)!
                //let isUser = String(temp.contributorEmail!.dropFirst(28))
                var actionName = String(temp.actionName!.dropFirst(30))
                actionName = actionName.replacingOccurrences(of: "%20", with: " ")
                
                if actions.contains(actionName)
                {
                    temp.isUserDonation = false
                    transactions.append(temp)
                }
            }
            
            transactionsView.transactionsTableView.reloadData()
        }
        else if option == 1
        {
            let arrayOfDonations = response["donations"].arrayValue
            for donation in arrayOfDonations
            {
                let temp = DonationModel(JSONString: donation.rawString()!)
                temp?.isUserDonation = true
                transactions.append(temp!)
            }
            
            transactionsView.transactionsTableView.reloadData()
        }
        else if option == 3
        {
            let arrayOfActions = response.arrayValue
            for action in arrayOfActions
            {
                let temp = ActionModel(JSONString: action.rawString()!)!
                if temp.organizerEmail == getCurrentUserEmail()
                {
                    actions.append(temp.name!)
                }
            }
            getUserDonations()
            getDonationsToUserActions()
            
        }
        
    }
    
    func onFailure(error: String, option: Int?) {
        print(error)
    }
}
