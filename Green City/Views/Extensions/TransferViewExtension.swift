//
//  TransferViewExtension.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation

extension TransferView : CardIOPaymentViewControllerDelegate
{
    func showCardScanner()
    {
        CardIOUtilities.preload()
        let cardIOVC = CardIOPaymentViewController(paymentDelegate: self)
        cardIOVC?.collectCardholderName = false
        cardIOVC?.modalPresentationStyle = .currentContext
        cardIOVC?.guideColor = UIColor(red:0.0, green:1.0, blue:0.0, alpha:1.00)
        cardIOVC?.disableManualEntryButtons = false
        cardIOVC?.hideCardIOLogo = true
        present(cardIOVC!, animated: true, completion: nil)
    }
    
    func userDidCancel(_ paymentViewController: CardIOPaymentViewController!) {
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func userDidProvide(_ cardInfo: CardIOCreditCardInfo!, in paymentViewController: CardIOPaymentViewController!) {
        if let info = cardInfo {
            //let str = String(format: "Received card info.\n Cardholders Name: %@ \n Number: %@\n expiry: %02lu/%lu\n cvv: %@.", info.cardholderName,info.redactedCardNumber
            //    , info.expiryMonth, info.expiryYear, info.cvv)
            
            //            txtCardHolderName.text = info.cardholderName
            //
            //            txtNumber.text = info.redactedCardNumber
            //
            //            txtExpiry.text = String(format:"%02lu/%lu\n",info.expiryMonth,info.expiryYear)
            //
            //            txtCvv.text = info.cvv
            
            //print(str)
            transferViewModel.applyPayment()
            
        }
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
}
