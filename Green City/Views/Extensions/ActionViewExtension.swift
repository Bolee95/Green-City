//
//  ActionExtension.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/17/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI

extension ActionView
{

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actionsTableView.deselectRow(at: indexPath, animated: true)
        clickedRow = indexPath.row
        performSegue(withIdentifier: "toProfileSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = actionsTableView.dequeueReusableCell(withIdentifier: "actionCell", for: indexPath)  as! ActionTableViewCell
        let Action = actionViewModel.filteredActions[indexPath.row]
        cell.actionDeadline.text = String((Action.date?.prefix(12))!)
        cell.actionName.text = Action.name!
        
        //Uzeti i novcanik i odatle proveriti
        let wallet = actionViewModel.wallets[Action.name!] as? Wallet
        print(wallet?.holderEmail!)
        if wallet != nil
        {
        
            let currentProgress = (wallet?.balance!)! / Action.moneyNeeded!
            cell.donatedProgress.setProgress(Float(currentProgress), animated: true)
            if currentProgress > 0.99
            {
                cell.donatedProgress.progressTintColor = UIColor.red
            }
            
        }
        //postavljanje slike u celiji
        let pathReference = storage.reference(withPath: "images/" + Action.name!)
        cell.actionImage.sd_setImage(with: pathReference, placeholderImage: UIImage(named: "logo"))
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 182
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionViewModel.filteredActions.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ActionDetailsView
        {
            destVC.actionNameString = actionViewModel.filteredActions[clickedRow].name!
        }
    }
    
    
    
}
