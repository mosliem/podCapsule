//
//  PodcastDetailsTableSectionHeader.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/5/22.
//

import UIKit


class PodcastDetailsTableSectionHeader: UIView{
    
    let sectionName: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2075826082, green: 0.2439847391, blue: 0.2462920368, alpha: 1)
        label.font = UIFont(name: "Helvetica Neue Bold", size: 18)
        label.text = "Episodes"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(sectionName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        sectionName.frame = CGRect(x: 10, y: 5, width: self.frame.width - 20, height: self.frame.height - 10)
    }
}
