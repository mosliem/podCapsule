//
//  SearchResultsDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/11/22.
//

import UIKit

extension SearchResultsVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.itemsForSection(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeue((presenter?.cellTypeForSection(for: indexPath.section))!, for: indexPath)
        presenter?.configureCell(for: indexPath.section, at: indexPath.row, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        view.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 5, y: 5, width: 150, height: 40))
        label.text = presenter?.titleForSection(for: section)
        label.font = UIFont(name: "Helvetica Neue Bold", size: 20)
        label.textColor = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
        
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selectCell(for: indexPath.section, at: indexPath.row)
    }
}


extension SearchResultsVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.typingStarted()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter?.searchBarChanged(with: searchBar.text)
    }
    
    
}

extension SearchResultsVC: SearchResultsView {
    
    func showNoResultsAnimation() {
        noResultsAnimationView.isHidden = false
        noResultsAnimation?.isHidden = false
        
        noResultsAnimation = .init(name: "noSearchResults")
        
        noResultsAnimation?.frame = CGRect(
            x: 0, y: 0,
            width: noResultsAnimationView.frame.width,
            height: noResultsAnimationView.frame.height
        )
        
        noResultsAnimation?.animationSpeed = 0.7
        noResultsAnimation?.play()
        noResultsAnimation?.loopMode = .loop
        
        noResultsAnimationView.addSubview(noResultsAnimation!)
    }
    
    func hideNoResultsAnimation() {
        
        noResultsAnimationView.isHidden = true
        noResultsAnimation?.isHidden = true
        noResultsAnimation?.stop()
        
    }
    
    func hideResultsTableView(){
        resultsTableView.isHidden = true
    }
    
    func showResultsTableView(){
        resultsTableView.isHidden = false
    }
    
    func showErrorAlert(title: String, message: String)
    {
        self.showAlertWithOk(alertTitle: title, message: message, actionTitle: "OK")
    }
    
    func reloadTableDate() {
        
        DispatchQueue.main.async {
            self.resultsTableView.reloadData()
        }
    }
    
    func showLoadingIndicator() {
        self.showIndicator()
    }
    
    func hideLoadingIndicator() {
        self.hideIndicator()
    }
    
    func showNoResultsLabel() {
        noResultsLabel.isHidden = false
    }
    
    func hideNoResultsLabel() {
        noResultsLabel.isHidden = true
    }
    
    func deselectCell() {
        
        let indexPath = resultsTableView.indexPathForSelectedRow
        Timer.scheduledTimer(withTimeInterval: 0.7, repeats: false) { (_) in
            self.resultsTableView.deselectRow(at: indexPath!, animated: true)
        }
    }
    
    
}
