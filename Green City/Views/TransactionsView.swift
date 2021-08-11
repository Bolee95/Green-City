//
//  TransactionsView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/20/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit
import Foundation

class TransactionsView: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var transactionsTableView: UITableView!
    var transactionsViewModel = TransactionsViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        transactionsTableView.delegate = self
        transactionsTableView.dataSource = self
        transactionsViewModel.transactionsView = self
        transactionsViewModel.getActionsDonations()
        // Do any additional setup after loading the view.
    }

}
