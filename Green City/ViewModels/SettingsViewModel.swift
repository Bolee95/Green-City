//
//  SettingsViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/24/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire
import FirebaseUI
import SwiftyJSON

class SettingsViewModel : NetworkResponseProtocol
{
    
    var settingsView : SettingsView!
    var user : UserModel!
    
    func loadUserData()
    {
        Alamofire.SessionManager.default.request(UserRouter.getUserById(email: getCurrentUserEmail())).responseJSON {response in
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
    
    func updateUserProfile()
    {
        let pathReference = storage.reference(withPath: "images/" + user.email!)
        settingsView.userImage.sd_setImage(with: pathReference, placeholderImage: UIImage(named: "logo"))
        settingsView.ammountDonatedField.text = String(format: "%.2f",user.totalDonated!) + "$ donated"
        settingsView.nameAndSurnameField.text = user.firstName! + " " + user.lastName!
        settingsView.cityStateField.text = user.address!.city + ", " + user.address!.country
        
    }
        
    func onSuccess(response: JSON, option: Int?) {
        let address = Address(JSONString: response["address"].rawString()!)
        user = UserModel(JSONString: response.rawString()!)!
        user.address = address!
        updateUserProfile()
    }
        
    func onFailure(error: String, option: Int?) {
    }
    
    func uploadImage()
    {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageRef = storageRef.child("images/" + user.email!)
        
        let imageData =  UIImageJPEGRepresentation(settingsView.userImage.image!, 1.0)
        if let _ = settingsView.pickedImageURL
        {
            let _ = imageRef.putData(imageData!, metadata: metadata) { (metadata,error) in
                guard let _ = metadata else
                {
                    self.settingsView.showMessage(message: "Error uploading image!", title : "Something went wrong...")
                    return
                }
                self.settingsView.loadingIndicator.stopAnimating()   
            }
        }
    }
}
