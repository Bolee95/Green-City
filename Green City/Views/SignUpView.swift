//
//  SignUpView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/16/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class SignUpView: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var backToLoginButton: UIButton!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var Cityfield: UITextField!
    @IBOutlet weak var countryField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var proceedButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    // MARK : view model
    var signUpViewModel = SignUpViewModel()
    let imagePickerController = UIImagePickerController()
    var pickedImageURL : NSURL? = nil
    var alertController : UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signUpViewModel.signUpView = self
        loadingIndicator.stopAnimating()
        imagePickerController.delegate = self
        
        //Prepoznavanje klika na sliku
        let tapGestureRecognizerImageProfile = UITapGestureRecognizer(target: self, action: #selector(profileImageTaped(tapGestureRecognizer:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(tapGestureRecognizerImageProfile)
        
        //rounded image
        userImage.layer.cornerRadius = self.userImage.frame.size.width / 2;
        userImage.clipsToBounds = true;
        
        roundButtons()
    }
    
    func roundButtons()
    {
        proceedButton.layer.borderWidth = 1
        proceedButton.layer.cornerRadius = 10
    }
    
    
    //MARK : tap on image action
    @objc func profileImageTaped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        userImage.image = selectedImage
        pickedImageURL = info[UIImagePickerControllerReferenceURL] as? NSURL
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: Back to login screen
    @IBAction func backToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: processing request for sign up
    //TAG1.1: Sredi da se ne vide modeli...
    @IBAction func proceedButtonPressed(_ sender: UIButton) {
        loadingIndicator.startAnimating()
        
        let address = Address.init(city: Cityfield.text!, country: countryField.text!, street: "", zip: "")
        let user = UserModel.init(firstName: nameField.text!, lastName: surnameField.text!, email: emailField.text!, address: address)
       
        signUpViewModel.makeNewWallet(user: user, password: passwordField.text!)
    }
    
    func signUpSuccessMessage()
    {
        loadingIndicator.stopAnimating()
        alertController = UIAlertController(title: "Sign Up", message:
            "Sign Up successfull!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController,animated: true)
    }
    
    func signUpFailMessage(message : String)
    {
        loadingIndicator.stopAnimating()
        alertController = UIAlertController(title: "Sign Up failed", message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {
            action in
            self.alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController,animated: true)
    }
}
