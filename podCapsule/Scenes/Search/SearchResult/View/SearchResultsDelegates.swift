//
//  SearchResultsDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/11/22.
//

import UIKit


extension SearchResultsVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewCell.identifier, for: indexPath) as! SearchResultsTableViewCell
        return cell
    
    }
    
}

extension SearchResultsVC: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//        print(searchController.searchBar.text)
    }
}

extension SearchResultsVC: UISearchBarDelegate{
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        print(searchBar.text)
    }
}

extension SearchResultsVC: SearchResultsView {
    
  
}
