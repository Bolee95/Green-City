//
//  ActionView.swift
//  Green City
//
//  Created by Bogdan Ilic on 9/17/18.
//  Copyright © 2018 Bogdan Ilic. All rights reserved.
//

import UIKit

class ActionView: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var actionsSearchBar: UISearchBar!
    @IBOutlet weak var actionsTableView: UITableView!
    var clickedRow : Int = 0
    
    var actionViewModel = ActionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actionsSearchBar.delegate = self
        actionViewModel.actionView = self
        actionsTableView.delegate = self
        actionsTableView.dataSource = self
        
        actionViewModel.loadActions()
        actionsTableView.separatorColor = UIColor.clear
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        actionViewModel.filter(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    
}
