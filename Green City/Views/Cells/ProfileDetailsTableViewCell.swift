//
//  ProfileDetailsTableViewCell.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/22/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class ProfileDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var donationText: UILabel!
    @IBOutlet weak var donationPicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        donationPicture.layer.cornerRadius = self.donationPicture.frame.size.width / 2
        donationPicture.clipsToBounds = true
    }
}
