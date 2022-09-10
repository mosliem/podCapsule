//
//  TabBarPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

class TabBarPresenter: TabBarViewPresenter {
   
    var router: TabBarViewRouter?
    var view: TabBarView?
    
    
    required init(view: TabBarView, router: TabBarViewRouter) {
        self.view = view
        self.router = router
    }
    
    func viewWillAppear() {
        router?.setupTabBarNavigation()
    }
    
    
}
