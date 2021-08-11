//
//  DonationView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/21/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class DonationView: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var donatorEmailField: UILabel!
    @IBOutlet weak var actionNameField: UILabel!
    @IBOutlet weak var moneyDonatedField: UITextField!
    @IBOutlet weak var commitButton: UIButton!
    
    var actionName : String = ""
    var donationViewModel = DonationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        donationViewModel.donationView = self
        loadingIndicator.stopAnimating()
        donatorEmailField.text = getCurrentUserEmail()
        actionNameField.text = actionName
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func commitButtonPressed(_ sender: UIButton) {
        loadingIndicator.startAnimating()
        donationViewModel.performTransaction(actionName : actionName, donatorEmail: getCurrentUserEmail(), ammount : Double(moneyDonatedField.text!)!)
    }
    
    func showTransactionStatus(message : String, title: String)
    {
        loadingIndicator.stopAnimating()
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {
            action in
            self.dismiss(animated: true, completion: nil)
        }
        ))
        self.present(alertController,animated: true)
    }
}
