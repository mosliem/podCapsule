//
//  SectionSearchButton.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

protocol SearchButtonDelegate: class {
    func searchButtonPressed()
}

class SearchButtonView: UIView {

    weak var delegate: SearchButtonDelegate?
    
    private let searchButton: UIButton = {
        let button = UIButton()
       
        let image = UIImage(systemName: "magnifyingglass")?
            .applyingSymbolConfiguration(.init(pointSize: 20, weight: .medium, scale: .large))
        button.setImage(image, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0 , left: -50, bottom: 0, right: 0)

        button.setTitle("search episodes, podcasts", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica Neue Medium", size: 18)
        button.setTitleColor(#colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: -2, left: -30, bottom: 0, right: 0)
        
        button.clipsToBounds = true
        button.layer.cornerRadius = 7.5
        
        button.backgroundColor = #colorLiteral(red: 0.8979603648, green: 0.8980897069, blue: 0.8979320526, alpha: 1)
        button.tintColor = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        searchButton.frame = CGRect(x: 25, y: 10, width: frame.size.width - 50, height: 45)
    }
  
    @objc private func searchButtonPressed(){
        delegate?.searchButtonPressed()
    }
}
