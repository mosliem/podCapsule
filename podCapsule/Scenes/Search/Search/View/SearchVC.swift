//
//  SearchVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var suggestedPodcastsTableView: UITableView!
    var presenter: SearchViewPresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        suggestedPodcastsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        suggestedPodcastsTableView.delegate = self
        suggestedPodcastsTableView.dataSource = self
        
    }

    
    
}
