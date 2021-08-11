//
//  TransactionsViewExtension.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import UIKit

extension TransactionsView
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transactionsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = transactionsTableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath)  as! TransactionTableViewCell
        let transactionItem = transactionsViewModel.transactions[indexPath.row]
        if (transactionItem.isUserDonation)
        {
            cell.ammountField.text =  String(format: "%.2f", transactionItem.ammount!)
            cell.transactionID.text = transactionItem.transactionID!
            cell.dateField.text = String(transactionItem.date!.dropLast(5))
            cell.imageView?.image =  UIImage(named: "transaction-icon1")
        }
        else
        {
            cell.ammountField.text =  String(format: "%.2f", transactionItem.ammount!) + "$"
            cell.transactionID.text = transactionItem.transactionID!
            cell.dateField.text = String(transactionItem.date!.dropLast(5))
            cell.imageView?.image =  UIImage(named: "transaction-icon2")
        }
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        transactionsTableView.separatorColor = UIColor.gray
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactionsViewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
