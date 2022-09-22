//
//  UITableViewExtension.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/16/22.
//

import UIKit

extension UITableView{
    
    func dequeue<T: UITableViewCell>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as!  T
    }
    
}
