//
//  TransactionTableViewCell.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var ammountField: UILabel!
    @IBOutlet weak var transactionID: UILabel!
    @IBOutlet weak var transactImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        //rounded image
        transactImage.layer.cornerRadius = self.transactImage.frame.size.width / 2
        transactImage.clipsToBounds = true
    }
}
