//
//  ActionDetailsView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class ActionDetailsView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var actionPicture: UIImageView!
    @IBOutlet weak var actionName: UILabel!
    @IBOutlet weak var actionProgress: UIProgressView!
    @IBOutlet weak var collectedMoney: UILabel!
    @IBOutlet weak var neededMoney: UILabel!
    @IBOutlet weak var donateButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var contributorsTableView: UITableView!
    var actionNameString : String = ""
    var clickedRow : Int = 0
    
    var actionDetailsViewModel = ActionDetailsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        actionDetailsViewModel.actionDetailsView = self
        contributorsTableView.delegate = self
        contributorsTableView.dataSource = self
        
        actionPicture.layer.cornerRadius = self.actionPicture.frame.size.width / 2
        actionPicture.clipsToBounds = true
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        actionDetailsViewModel.donators.removeAll()
        actionDetailsViewModel.loadInfo(name: actionNameString)
        
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func donateButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "donateSegue", sender: nil)
    }

    
}
