//
//  SearchVCDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit


extension SearchVC: SearchView {
    
    func hideNavigationBar() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "search history"
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SearchButtonView()
        view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        view.delegate = self
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 65
    }
    

}

extension SearchVC: UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        presenter?.tableScrolled(with:Float(scrollView.contentOffset.y))
        
        
    }
    
}

extension SearchVC: SearchButtonDelegate{
    
    func searchButtonPressed() {
        presenter?.searchPressed()
    }
    
}

