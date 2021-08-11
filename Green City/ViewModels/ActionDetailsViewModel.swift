//
//  ActionDetailsViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/21/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ActionDetailsViewModel : NetworkResponseProtocol
{
    var actionDetailsView : ActionDetailsView!
    var action : ActionModel!
    var donators = [Cheque]()
    var wallet : Wallet!
    
    func getWalletBalance()
    {
       print(actionDetailsView.actionNameString)
        Alamofire.SessionManager.default.request(WalletRouter.getWalletById(holderEmail: actionDetailsView.actionNameString)).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        let jsonVar = JSON(response.result.value!)
                        self.onSuccess(response: jsonVar,option: 1)
                        
                    case 401,422,400,500,404:
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
    
    func loadInfo(name : String)
    {
        Alamofire.SessionManager.default.request(ActionRouter.getActionById(name: name)).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value as Any)
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
    
    
    func updateView()
    {
        actionDetailsView.actionName.text = action.name!
        //actionDetailsView.collectedMoney.text = String(format: "%.2f", action.moneyNeeded!)
        //actionDetailsView.actionProgress.progress = Float(2 / action.moneyNeeded!)
        actionDetailsView.neededMoney.text = String (format: "%.2f",action.moneyNeeded! ) + "$ needed"
        actionDetailsView.descriptionTextField.text = action.description!
        let pathReference = storage.reference(withPath: "images/" + action.name!)
        actionDetailsView.actionPicture.sd_setImage(with: pathReference, placeholderImage: UIImage(named: "logo"))
    }
    
    func updateViewWithWallet()
    {
        actionDetailsView.collectedMoney.text = String(format: "%.2f", wallet.balance!) + "$ collected"
        let currentProgress = wallet.balance! / action.moneyNeeded!
        actionDetailsView.actionProgress.setProgress(Float(currentProgress), animated: true)
        if currentProgress > 0.99
        {
            actionDetailsView.actionProgress.progressTintColor = UIColor.red
        }
    }
    
    func onSuccess(response: JSON, option: Int?) {
        if option == 2
        {
            let address = Address(JSONString: response["address"].rawString()!)
            action = ActionModel(JSONString: response.rawString()!)
            action.address = address!
            let donations = response["contributors"].arrayValue
            for donation in donations
            {
                let temp = Cheque(JSONString: donation.rawString()!)
                donators.append(temp!)
            }
            actionDetailsView.contributorsTableView.reloadData()
            updateView()
            getWalletBalance()
        }
        else if option == 1
        {
            wallet = Wallet(JSONString: response.rawString()!)
            updateViewWithWallet()
        }
    }
    
    func onFailure(error: String, option: Int?) {
        
    }
    
    
}

