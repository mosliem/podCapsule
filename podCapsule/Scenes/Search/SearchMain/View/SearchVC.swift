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
        setupNavigationBarAppearance()
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = "Search"
        presenter?.viewDidLoad()
        configureTableView()

    }
    
    private func setupNavigationBarAppearance(){
        
        let color = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
        let appearance = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
        
        appearance.titleTextAttributes = attributes
        appearance.largeTitleTextAttributes = attributes
        
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    private func configureTableView(){
        suggestedPodcastsTableView.delegate = self
        suggestedPodcastsTableView.dataSource = self
        
        suggestedPodcastsTableView.register(
            UINib(nibName: SuggestedPodcastsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: SuggestedPodcastsTableViewCell.identifier
        )
        
    }
    
}
