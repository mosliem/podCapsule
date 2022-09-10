//
//  UIViewControllerExtension.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

extension UIViewController{
    
    func showAlertWithOk(alertTitle: String,message: String,actionTitle: String){
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
//        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        self.present(alert, animated: true, completion: nil)
    }
    
}
