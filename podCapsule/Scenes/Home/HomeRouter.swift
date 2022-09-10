//
//  HomeRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

class HomeRouter{
    
    static func create() -> UIViewController {
        
        let view = HomeVC()
        let networkInteractor = HomeNetworkInteractor()
        let localInteractor = HomeLocalInteractor()
        let presenter = HomePresenter(view: view, networkInteractor: networkInteractor, localInteractor: localInteractor)
        
        view.presenter = presenter
        networkInteractor.presenter = presenter
        localInteractor.presenter = presenter
        
        return view
    }
}
