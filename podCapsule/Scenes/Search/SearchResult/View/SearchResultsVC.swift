//
//  SearchResultsVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class SearchResultsVC: UIViewController {

    @IBOutlet weak var resultsTableView: UITableView!
    var presenter: SearchResultsViewPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
    }

    private func configureTableView(){
        
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(
            UINib(nibName: SearchResultsTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: SearchResultsTableViewCell.identifier)
    }
     

}
