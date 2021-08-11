//
//  ContributorTableViewCell.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/21/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class ContributorTableViewCell: UITableViewCell {

    @IBOutlet weak var donatedAmmount: UILabel!
    @IBOutlet weak var donatorName: UILabel!
    @IBOutlet weak var contributorImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        contributorImage.layer.cornerRadius = self.contributorImage.frame.size.width / 2
        contributorImage.clipsToBounds = true
        // Initialization code
    }
}
