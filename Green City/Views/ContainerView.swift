//
//  ContainerView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/17/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class ContainerView: UIViewController {
    @IBOutlet weak var balanceField: UILabel!
    @IBOutlet weak var newActionButton: UIButton!
    var containerViewModel = ContainerViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        containerViewModel.containerView = self
        containerViewModel.updateBalance()
    }

    //MARK : Button for new action pressed
    @IBAction func newActionButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "createActionSegue", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        containerViewModel.updateBalance()
    }
}
