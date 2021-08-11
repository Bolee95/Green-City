//
//  ProfileView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/17/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class ProfileView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var donationsTableView: UITableView!
    @IBOutlet weak var userProfile: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var numOfDonationField: UILabel!
    @IBOutlet weak var userCity: UILabel!
    @IBOutlet weak var goBackButton: UIButton!
    
    
    var userEmail : String = ""
    var profileViewModel  = ProfileViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        donationsTableView.delegate = self
        donationsTableView.dataSource = self
        profileViewModel.profileView = self
        profileViewModel.loadUserData(email: userEmail)
        // Do any additional setup after loading the view.
        
        
        userProfile.layer.cornerRadius = self.userProfile.frame.size.width / 2
        userProfile.clipsToBounds = true
    }

    
    @IBAction func goBackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
