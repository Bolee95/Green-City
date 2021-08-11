//
//  CardScanView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit


class CardScanView: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CardIOUtilities.preload()
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.collectCardholderName = true
        cardIOVC?.modalPresentationStyle = .formSheet
        cardIOVC?.guideColor = UIColor(red:0.13, green:0.54, blue:0.61, alpha:1.00)
        cardIOVC?.disableManualEntryButtons = true
        cardIOVC?.hideCardIOLogo = true
        present(cardIOVC!, animated: true, completion: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
}

// extension for CardIOPaymentViewControllerDelegate

extension CardScanView : CardIOPaymentViewControllerDelegate {
    
    // Close ScanCard Screen
    public func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    // Using this delegate method, retrive card information
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            let str = String(format: "Received card info.\n Cardholders Name: %@ \n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.cardholderName,info.redactedCardNumber
                , info.expiryMonth, info.expiryYear, info.cvv)
            
//            txtCardHolderName.text = info.cardholderName
//
//            txtNumber.text = info.redactedCardNumber
//
//            txtExpiry.text = String(format:"%02lu/%lu\n",info.expiryMonth,info.expiryYear)
//
//            txtCvv.text = info.cvv
            
            print(str)
        }
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
}


