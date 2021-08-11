//
//  NewActionView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class NewActionView: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate  {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var newActionButton: UIButton!
    @IBOutlet weak var actionDescription: UITextView!
    @IBOutlet weak var moneyNeeded: UITextField!
    @IBOutlet weak var actionCountry: UITextField!
    @IBOutlet weak var actionZip: UITextField!
    @IBOutlet weak var actionStreet: UITextField!
    @IBOutlet weak var actionCity: UITextField!
    @IBOutlet weak var actionName: UITextField!
    @IBOutlet weak var actionImage: UIImageView!
    var alertController : UIAlertController!
    
    var newActionViewModel = NewActionViewModel()
    let imagePickerController = UIImagePickerController()
    var pickedImageURL : URL? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.stopAnimating()
        newActionViewModel.newActionView = self
        imagePickerController.delegate = self
        
        //Prepoznavanje klika na sliku
        let tapGestureRecognizerImageProfile = UITapGestureRecognizer(target: self, action: #selector(profileImageTaped(tapGestureRecognizer:)))
        actionImage.isUserInteractionEnabled = true
        actionImage.addGestureRecognizer(tapGestureRecognizerImageProfile)
        
        //rounded image
        actionImage.layer.cornerRadius = self.actionImage.frame.size.width / 2
        actionImage.clipsToBounds = true
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
        pickedImageURL = info[UIImagePickerControllerReferenceURL] as! URL 
        actionImage.image = selectedImage
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func createNewActionPressed(_ sender: UIButton) {
        loadingIndicator.startAnimating()
        let address = Address(city: actionCity.text!, country: actionCountry.text!, street: actionStreet.text!, zip: actionZip.text!)
        let action = ActionModel(orgEmail: getCurrentUserEmail(), name: actionName.text!, longitude: 0, latitude: 0, address: address, desc: actionDescription.text!, moneyNeeded: Double(moneyNeeded.text!)!, date: DateFormatter.localizedString(from: NSDate() as Date, dateStyle: .medium, timeStyle: .short))
        newActionViewModel.initCreateNewAction(action : action)
    }
    
    
    func showMessage(message: String, title: String)
    {
        loadingIndicator.stopAnimating()
        alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {
            action in
            self.dismiss(animated: true, completion: nil)
            
        }
        ))
        self.present(alertController,animated: true)
    }
    
    func actionCreateSuccess(message: String, title: String)
    {
        loadingIndicator.stopAnimating()
        alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {
            action in
            self.alertController.dismiss(animated: true, completion: nil)
            self.dismiss(animated: true, completion: nil)
        }
        ))
        self.present(alertController,animated: true)
    }
}
