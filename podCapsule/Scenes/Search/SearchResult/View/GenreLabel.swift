//
//  GenreLabel.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/22/22.
//

import UIKit

class GenreLabel: UILabel {

    var edgeInset: UIEdgeInsets = .zero
    
    func setEdgeInsets(insets: UIEdgeInsets){
        self.edgeInset = insets
    }
    

    open override func draw(_ rect: CGRect) {
        let insets = UIEdgeInsets.init(top: self.edgeInset.top, left: self.edgeInset.left, bottom: self.edgeInset.bottom, right: self.edgeInset.right)
        super.draw(rect.inset(by: insets))
    }

    open override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + self.edgeInset.left + self.edgeInset.right, height: size.height + self.edgeInset.top + self.edgeInset.bottom)
    }
}
