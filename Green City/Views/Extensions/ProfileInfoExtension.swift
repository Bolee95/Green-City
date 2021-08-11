//
//  ProfileInfoExtension.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/22/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import Foundation

extension ProfileView 
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        donationsTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = donationsTableView.dequeueReusableCell(withIdentifier: "profileDonationCell", for: indexPath)  as! ProfileDetailsTableViewCell
        let transactionItem = profileViewModel.donations[indexPath.row]
        cell.donationText.text =  "Donated " + String(format: "%.2f", transactionItem.ammount!) + " to action named " + transactionItem.actionName!.dropFirst(30).replacingOccurrences(of: "%20", with: " ")
        
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
        return 120
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModel.donations.count
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
}
