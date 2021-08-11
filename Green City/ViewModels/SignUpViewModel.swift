//
//  SignUpViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/16/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Firebase
import Alamofire

class SignUpViewModel
{
    var signUpView : SignUpView!
    
    func uploadImage()
    {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageRef = storageRef.child("images/" + signUpView.emailField.text!)
        
        let imageData =  UIImageJPEGRepresentation(signUpView.userImage.image!, 1.0)
        if let _ = signUpView.pickedImageURL
        {
            let uploadTask = imageRef.putData(imageData!, metadata: metadata) { (metadata,error) in
                guard let metadata = metadata else
                {
                    self.signUpView.signUpFailMessage(message: (error?.localizedDescription)!)
                    return
                }
                 self.signUpView.signUpSuccessMessage()
            }
        }
    }
    
    func makeNewWallet(user: UserModel, password: String)
    {
        let parameters : Parameters =
        [
            "holderEmail" : user.email!,
            "balance" : 0,
            "lastUpdated" : DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .medium)
        ]
        
        Alamofire.SessionManager.default.request(WalletRouter.createWallet(parameters: parameters)).responseJSON {response in
            var message = ""
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        self.createNewUser(user: user, password: password)
                        //let swiftyJsonVar = JSON(response.result.value!)
                        //self.onSuccess(json: swiftyJsonVar, option: 1)
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
    
    
    func createNewUser(user : UserModel, password : String)
    {
        
        let address: [String: String] =
        [
            "city" : user.address!.city,
            "country" : user.address!.country
        ]
        
        let parameters : Parameters =
            [
                "email" : user.email!,
                "firstName" : user.firstName!,
                "lastName" : user.lastName!,
                "address" : address,
                "totalDonated" : 0,
                "type" : "Greenie",
                "wallet" : "resource:org.GreenCity.Wallet#\(user.email!)",
        ]
        
        Alamofire.SessionManager.default.request(UserRouter.addUser(parameters: parameters)).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        self.createAuthForUser(email: user.email!, password: password)
                        //self.signUpView.signUpSuccessMessage()
                        //self.createNewUser(user: user)
                        //let swiftyJsonVar = JSON(response.result.value!)
                    //self.onSuccess(json: swiftyJsonVar, option: 1)
                    case 401: break
                    //self.onError(error: "You are not authorized to perform this action!", option: 0)
                    case 422: break
                    //self.onError(error: "Action could not be performed. Please, try later.", option: 0)
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
    
    func createAuthForUser(email: String, password: String)
    {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            print(error.debugDescription)
            if authResult != nil
            {
                self.uploadImage()
            }
            else
            {
                self.signUpView.signUpFailMessage(message: (error?.localizedDescription)!)
                print("Nije napravilo auth!")
            }
        }

        
    }
   
}
