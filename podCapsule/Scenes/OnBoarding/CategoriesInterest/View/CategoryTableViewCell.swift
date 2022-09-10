//
//  CategoryTableViewCell.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/9/22.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static let identifier = "CategoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }


}

extension CategoryTableViewCell: CategoryCellView {
    
    func displayCategoryTitle(title: String) {
        self.textLabel?.text = title
    }
    
    func setMarked() {
        self.accessoryType = .checkmark
    }
    
    func setUnmarked() {
        self.accessoryType = .none
    }
    
    
}

