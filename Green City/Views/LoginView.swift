//
//  ViewController.swift
//  Green City
//
//  Created by Bogdan Ilic on 8/10/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class LoginView: UIViewController
{
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    let viewModel = LoginViewModel()
    
    //za vracanje nakon logouta
    @IBAction func unwindAfterLogout(segue:UIStoryboardSegue) { }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loginView = self
        loadingIndicator.stopAnimating()
        viewModel.isRedirect()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK: SignUp button click
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SignUpSegue", sender: self)
        
    }
    
    //MARK: Login button click
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        loadingIndicator.startAnimating()
        viewModel.tryLogin(username: usernameField.text!, password: passwordField.text!)
    }
    
    
    func performLogin()
    {
        showBubbleAction(title: "Login", message: "Login successfull!",isLogin: true)
    }
    
    func showErrorMessage()
    {
       showBubbleAction(title: "Login", message: "Login failed!",isLogin: false)
    }
    
    
    func showBubbleAction(title: String, message: String, isLogin: Bool)
    {
        loadingIndicator.stopAnimating()
        
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {
            action in
            if isLogin
            {
                self.performSegue(withIdentifier: "mainViewSegue", sender: self)
            }
            else
            {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        self.present(alertController,animated: true)
    }
    
    func alreadyLoggedIn()
    {
        self.performSegue(withIdentifier: "mainViewSegue", sender: self)
    }
    
}

