//
//  NewActionViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/21/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation
import Firebase

class NewActionViewModel
{
    var newActionView : NewActionView!
    var longitude = 0.0
    var latitude = 0.0
    
    func initCreateNewAction(action: ActionModel)
    {
        createNewWallet(holderEmail : action.name!, action : action)
    }
    
    func uploadImage()
    {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageRef = storageRef.child("images/" + newActionView.actionName.text!)
        
        let imageData =  UIImageJPEGRepresentation(newActionView.actionImage.image!, 1.0)
        if newActionView.pickedImageURL != nil
        {
            let uploadTask = imageRef.putData(imageData!, metadata: metadata) { (metadata,error) in
                guard let metadata = metadata else
                {
                     self.newActionView.showMessage(message: "Image could not be uploaded!", title: "Failure")
                    return
                }
                self.newActionView.actionCreateSuccess(message: "You have created new Action!", title: "Success")
            }
        }
        else
        {
            self.newActionView.actionCreateSuccess(message: "You have created new Action!", title: "Success")
        }
    }
    
    
    func createNewWallet(holderEmail: String, action: ActionModel)
    {
        let parameters : Parameters =
            [
                "holderEmail" : holderEmail,
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
                        self.findLatLong(action: action)
                        //self.createNewAction(action : action)
                    case 401,422,500:
                        self.newActionView.showMessage(message: "Wallet already exists!", title: "Failure")
                        break
                    default:
                        break
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
                self.newActionView.showMessage(message: "Error while trying to create new Wallet!", title: "Failure")
                print(message)
            }
        }
    }
    
    func findLatLong(action: ActionModel)
    {
        let stringAddress = action.address?.fullAddress()
        
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(stringAddress!) { (placemarks, error) in
            if error == nil
            {
                let placemarks = placemarks
                let location = placemarks?.first?.location
                self.longitude = (location?.coordinate.longitude)!
                self.latitude = (location?.coordinate.latitude)!
                self.createNewAction(action : action)
            }
            else
            {
                self.newActionView.showMessage(message: "Could not get coordinates from address!", title: "failure")
                    return
            }
        }
    }
    
    func createNewAction(action : ActionModel)
    {
        let address: [String: String] =
            [
                "city" : action.address!.city,
                "country" : action.address!.country,
                "zip" : action.address!.zip!,
                "street" : action.address!.street!
        ]
        
        let parameters : Parameters =
            [
                "organiserEmail" : action.organizerEmail!,
                "name" : action.name!,
                "longitude" : longitude,
                "latitude" : latitude,
                "address" : address,
                "description" : action.description!,
                "moneyNeeded" : action.moneyNeeded!,
                "status" : "Started",
                "date" : action.date!,
                "wallet" : "resource:org.GreenCity.Wallet#\(action.name!)",
                "completed" : false
        ]
        
        Alamofire.SessionManager.default.request(ActionRouter.addAction(parameters: parameters)).responseJSON {response in
            var message : String?
            
            switch(response.result) {
            case .success( _):
                if let httpStatusCode = response.response?.statusCode {
                    switch(httpStatusCode) {
                    case 200:
                        print(response.result.value)
                        self.uploadImage()
                    case 401,422,400,500:
                        print(response.result.debugDescription)
                        self.newActionView.showMessage(message: response.result.description, title: "Failure")
                        break
                    default:
                        break
                    }
                }
            case .failure(let error):
                message = error.localizedDescription
                print(message)
                self.newActionView.showMessage(message: message!, title: "Failure")
            }
        }
        
    }
}
