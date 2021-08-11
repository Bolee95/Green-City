//
//  ApplicationSettings.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/23/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//
import Foundation
import FirebaseStorage
import FirebaseCore


let storage = Storage.storage()
let storageRef = storage.reference()
let baseURLString = "http://localhost:3000/api/"
//dom
//let baseURLString = "http://192.168.43.124:3000/api/"
//firma
//let baseURLString = "http://192.168.0.21:3000/api/"
//kuci
//let baseURLString = "http://192.168.1.100:3000/api/"
let userNamespaceString = "org.GreenCity.User"
let actionNamespaceString = "org.GreenCity.Action"
let donationNamespaceString = "org.GreenCity.Donation"
let walletNamespaceString = "org.GreenCity.Wallet"
let pingNetworkString = "system/ping"
let historianNetworkString = "system/historian"


//For HyperledgerComposer datetime iso8601 firnat
extension Formatter {
    static let iso8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSXXXXX"
        return formatter
    }()
}

extension Date {
    var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
}

extension String {
    var dateFromISO8601: Date? {
        return Formatter.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
    }
}





func checkLoginState() -> Bool
{
    let prefs = UserDefaults.standard.bool(forKey: "loggedIn")
    return prefs
}

func changeLoginState()
{
    let prefs = UserDefaults.standard.bool(forKey: "loggedIn")
   
    if prefs == true
    {
        UserDefaults.standard.set(false, forKey: "loggedIn")
    }
    else
    {
        UserDefaults.standard.set(true, forKey: "loggedIn")
    }
}

func saveCurrentUserEmail(email: String)
{
    let prefs = UserDefaults.standard.set(email, forKey: "userEmail")
}

func getCurrentUserEmail() -> String
{
    let prefs  = UserDefaults.standard.string(forKey: "userEmail")
    return prefs!
}
