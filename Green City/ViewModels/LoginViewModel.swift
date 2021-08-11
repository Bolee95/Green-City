//
//  LoginViewModel.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/16/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import Firebase

class LoginViewModel 
{
    weak var loginView : LoginView!
    
    func tryLogin(username : String, password : String) 
    {        
        Auth.auth().signIn(withEmail: username,password: password)
        {
            (user,error) in
            print(error.debugDescription)
            if user != nil {
                saveCurrentUserEmail(email: username)
                changeLoginState()
                self.loginView.performLogin()
            }
            else {
                self.loginView.showErrorMessage()
            }
        }
    }
    
    func isRedirect()
    {
        if checkLoginState()
        {
            loginView.alreadyLoggedIn()
        }
    }
    
    
  
}
