//
//  TransferView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class TransferView: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scanCardButton: UIButton!
    @IBOutlet weak var codeField: UITextField!
    @IBOutlet weak var proceedCodeButton: UIButton!
    var alertController : UIAlertController!
    var transferViewModel = TransferViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        transferViewModel.transferView = self
        loadingIndicator.stopAnimating()
        // Do any additional setup after loading the view.
    }

    @IBAction func scanCardButtonPressed(_ sender: UIButton) {
        showCardScanner()
    }
    
    func showPaymentStatus(message : String, title: String)
    {
        loadingIndicator.stopAnimating()
        alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: {
            action in
                self.alertController.dismiss(animated: true, completion: nil)
            }
        ))
        self.present(alertController,animated: true)
    }
    @IBAction func codeProceedButtonPressed(_ sender: UIButton) {
        loadingIndicator.startAnimating()
        transferViewModel.checkCode(code: codeField.text!)
        
    }
}
