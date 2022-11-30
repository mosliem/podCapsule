//
//  SearchResultsVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit
import Lottie

class SearchResultsVC: UIViewController {

    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    @IBOutlet weak var noResultsAnimationView: UIView!
    internal var noResultsAnimation: AnimationView?
    
    var presenter: SearchResultsViewPresenter?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }


    
    private func configureTableView(){
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.contentInsetAdjustmentBehavior = .never
        
        resultsTableView.register(
            UINib(nibName: EpisodeResultsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: EpisodeResultsTableViewCell.identifier)
        
        resultsTableView.register(
            UINib(nibName: PodcastResultsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: PodcastResultsTableViewCell.identifier)
        
        resultsTableView.tableFooterView = UIView()
    }
     

}
