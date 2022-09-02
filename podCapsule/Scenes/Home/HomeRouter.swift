//
//  HomeRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

class HomeRouter{
    
    class func create() -> UIViewController {
        
        let homeVC = HomeVC()
        let presenter = HomePresenter(view: homeVC)
        homeVC.presenter = presenter
        return homeVC
    }
}
