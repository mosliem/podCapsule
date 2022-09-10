//
//  SearchVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var searchResultTableView: UITableView!
    var presenter: SearchViewPresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        searchResultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
    }


    
}
