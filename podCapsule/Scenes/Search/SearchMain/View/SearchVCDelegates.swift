//
//  SearchVCDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit


extension SearchVC: SearchView {
    
    
    func reloadsuggestedData() {
        DispatchQueue.main.async {
            self.suggestedPodcastsTableView.reloadData()
        }
    }
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    func showLoadingIndicator() {
        self.showIndicator()
    }
    
    func hideLoadingIndicator() {
        DispatchQueue.main.async {
            self.hideIndicator()
        }
    }
    
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.suggestedPodcastCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = suggestedPodcastsTableView.dequeueReusableCell(withIdentifier: SuggestedPodcastsTableViewCell.identifier, for: indexPath) as! SuggestedPodcastsTableViewCell
        
        presenter?.configure(for: cell, at: indexPath.row)
        return cell
    }
    
 
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter?.cellSelected(at: indexPath.row)
    }
}

extension SearchVC: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        presenter?.tableScrolled(with:Float(scrollView.contentOffset.y))
    }
    
}


