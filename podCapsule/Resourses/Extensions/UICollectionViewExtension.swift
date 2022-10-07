//
//  UICollectionView.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/6/22.
//

import UIKit


extension UICollectionView{
    
    func dequeue<T: UICollectionViewCell> (_ cellType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as!  T
    }
    
}

