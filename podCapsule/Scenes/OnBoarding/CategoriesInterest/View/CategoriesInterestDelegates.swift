//
//  IntersetsDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/9/22.
//

import UIKit

extension CategoriesInterestVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.categoriesCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        
        presenter?.configureCell(for: cell, at: indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! CategoryTableViewCell
        presenter?.selectCell(cell: cell, at: indexPath.row)
    }
    
}

extension CategoriesInterestVC: CategoriesInterestView{
    
    
    
    
}
