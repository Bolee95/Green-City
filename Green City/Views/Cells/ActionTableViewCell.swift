//
//  ActionTableViewCell.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/17/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class ActionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actionImage: UIImageView!
    @IBOutlet weak var donatedProgress: UIProgressView!
    @IBOutlet weak var actionDeadline: UILabel!
    @IBOutlet weak var actionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        actionImage.layer.cornerRadius = self.actionImage.frame.size.width / 2
        actionImage.clipsToBounds = true
    }

}
