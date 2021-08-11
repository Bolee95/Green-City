//
//  ActionDetailViewExtension.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/21/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation

extension ActionDetailsView 
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        contributorsTableView.deselectRow(at: indexPath, animated: true)
        clickedRow = indexPath.row
        performSegue(withIdentifier: "toUserProfileSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = contributorsTableView.dequeueReusableCell(withIdentifier: "contributorCell", for: indexPath)  as! ContributorTableViewCell
        let transactionItem = actionDetailsViewModel.donators[indexPath.row]
        cell.donatedAmmount.text =  String(format: "%.2f", transactionItem.ammount) + "$"
        cell.donatorName.text = transactionItem.contributorEmail
        let pathReference = storage.reference(withPath: "images/" + transactionItem.contributorEmail)
        cell.contributorImage.sd_setImage(with: pathReference, placeholderImage: UIImage(named: "logo"))
        
        cell.layer.transform = CATransform3DMakeScale(0.1,0.1,1)
        UIView.animate(withDuration: 0.3, animations: {
            cell.layer.transform = CATransform3DMakeScale(1.05,1.05,1)
        },completion: { finished in
            UIView.animate(withDuration: 0.1, animations: {
                cell.layer.transform = CATransform3DMakeScale(1,1,1)
            })
        })
        //transactionsTableView.separatorColor = UIColor.gray
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionDetailsViewModel.donators.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destVC = segue.destination as? ProfileView
        {
            destVC.userEmail = actionDetailsViewModel.donators[clickedRow].contributorEmail
        }
        else if let destVC = segue.destination as? DonationView
        {
            destVC.actionName = actionDetailsViewModel.action.name!
        }
    }
}
