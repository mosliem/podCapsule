//
//  HomeSectionsCollectionReusableView.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

class HomeSectionsCollectionReusableView: UICollectionReusableView {
        
        static let identifier = "HomeSectionTitlesReusableView"
        
        private let titleLabel : UILabel = {
            let label = UILabel()
            label.numberOfLines = 1
            label.font = UIFont(name: "Helvetica Neue Bold", size: 25)
            label.textColor = #colorLiteral(red: 0.0383454673, green: 0.1741192639, blue: 0.2161790133, alpha: 1)
            label.shadowOffset = CGSize.zero
            return label
        }()
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            backgroundColor = .systemBackground
            addSubview(titleLabel)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            titleLabel.frame = CGRect(x: 10, y:15 , width: self.bounds.width, height: 40)
            
        }
        required init?(coder: NSCoder) {
            fatalError()
        }
    
}


extension HomeSectionsCollectionReusableView: HomeCollectionReusableViewInput{
    
    func dispalySectionTitle(text: String) {
        titleLabel.text = text
    }
    
    
}
