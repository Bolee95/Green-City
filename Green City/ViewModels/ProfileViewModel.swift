//
//  ProfileViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/22/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ProfileViewModel : NetworkResponseProtocol {
    
    var profileView : ProfileView!
    var user : UserModel!
    var donations = [DonationModel]()
    func loadUserData(email: String)
    {
        Alamofire.SessionManager.default.request(UserRouter.getUserById(email: email)).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        let jsonVar = JSON(response.result.value!)
                        self.onSuccess(response: jsonVar,option: nil)
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
         let address = Address(JSONString: response["address"].rawString()!)
         let tempDonations = response["donations"].arrayValue
         for temp in tempDonations
         {
             let tempDonation = DonationModel(JSONString: temp.rawString()!)!
             donations.append(tempDonation)
         }
         user = UserModel(JSONString: response.rawString()!)!
         user.address = address!
         updateUserProfile()
         profileView.donationsTableView.reloadData()
     }
 
    
    func onFailure(error: String, option: Int?) {
        print(error)
    }
    
    func updateUserProfile()
    {
        profileView.userCity.text = "City of " + (user.address?.city)! + ", " + (user.address?.country)!
        profileView.userName.text = user.firstName! + " " + user.lastName!
        profileView.numOfDonationField.text = String(donations.count) + " " + "donations"
        let pathReference = storage.reference(withPath: "images/" + user.email!)
        profileView.userProfile.sd_setImage(with: pathReference, placeholderImage: UIImage(named: "logo"))
        
    
    }
}
