//
//  SettingsView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/24/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class SettingsView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var ammountDonatedField: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var cityStateField: UILabel!
    @IBOutlet weak var nameAndSurnameField: UILabel!
    
    var settingsViewModel = SettingsViewModel()
    let photoPicker = UIImagePickerController()
    var alertController = UIAlertController()
    var pickedImageURL : URL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoPicker.delegate = self
        settingsViewModel.settingsView = self
        
        //rounded Image
        userImage.layer.cornerRadius = self.userImage.frame.size.width / 2
        userImage.clipsToBounds = true
        
        //load current user data
        settingsViewModel.loadUserData()
        
        //set tap gesture on profile image
        let gesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTaped(tapGestureRecognizer:)))
        userImage.isUserInteractionEnabled = true
        userImage.addGestureRecognizer(gesture)
        
        loadingIndicator.stopAnimating()
    }
    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        changeLoginState()
        saveCurrentUserEmail(email: "")
        performSegue(withIdentifier: "unwindAfterLogout", sender: nil)
    }
    
    @objc func profileImageTaped(tapGestureRecognizer : UITapGestureRecognizer)
    {
        self.present(photoPicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        pickedImageURL = info[UIImagePickerControllerReferenceURL] as! URL
        userImage.image = selectedImage
        loadingIndicator.startAnimating()
        settingsViewModel.uploadImage()
        dismiss(animated: true, completion: nil)
    }
    
    func showMessage(message : String, title : String)
    {
        loadingIndicator.stopAnimating()
        alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {
            action in
            self.alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController,animated: true)
    }
    
    
}
