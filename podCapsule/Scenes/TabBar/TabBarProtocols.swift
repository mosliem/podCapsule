//
//  TabBarProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation


protocol TabBarView: class {
    
    var presenter: TabBarViewPresenter? { get set }
}

protocol TabBarViewPresenter: class {
    
    var view: TabBarView? { get set }
    var router: TabBarViewRouter? { get set }
    
    init(view: TabBarView, router: TabBarViewRouter)
    func viewWillAppear()
    
}


protocol TabBarViewRouter: class {
    
    func setupTabBarNavigation()
}
