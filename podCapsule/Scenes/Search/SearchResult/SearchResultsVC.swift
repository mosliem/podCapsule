//
//  SearchResultsVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class SearchResultsVC: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }

}
