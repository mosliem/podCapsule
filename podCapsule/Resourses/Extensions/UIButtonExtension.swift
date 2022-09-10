//
//  UIButtonExtension.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//


import UIKit

extension UIButton {
    
    func roundButtonWithShadows(cornerRadius: CGFloat? = 0, shadowRadius: CGFloat? = 0, shadowOpicity: Float? = 0, shadowOffset: CGSize? = .zero, shadowColor: UIColor? = .clear){
        
        self.layer.cornerRadius = cornerRadius!
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor?.cgColor
        self.layer.shadowRadius = shadowRadius!
        self.layer.shadowOpacity = shadowOpicity!
        self.layer.shadowOffset = shadowOffset ?? .zero
        
    }
}
