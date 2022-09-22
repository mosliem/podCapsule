//
//  UIViewControllerExtension.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit
import NVActivityIndicatorView

//MARK:- alerts

extension UIViewController{
    
    func showAlertWithOk(alertTitle: String,message: String,actionTitle: String){
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}



//MARK:- indicator view

var loadingIndicator: NVActivityIndicatorView?
var indicatorView: UIView?
extension UIViewController{
    

    func showIndicator(){
        
        indicatorView = UIView(frame: view.frame)
        indicatorView?.backgroundColor = .white
        
        let viewFrame = self.view.frame
        let frame = CGRect(x: viewFrame.width / 2 - 40, y: viewFrame.height / 2 - 40, width: 80, height: 80)
        let color = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
        
        loadingIndicator = NVActivityIndicatorView(frame: frame, type: .ballPulse, color: color, padding: 15)
        indicatorView?.addSubview(loadingIndicator!)

        view.addSubview(indicatorView!)
        loadingIndicator!.startAnimating()
    }
    
    func hideIndicator(){
        loadingIndicator?.stopAnimating()
        indicatorView?.removeFromSuperview()
    }
}
