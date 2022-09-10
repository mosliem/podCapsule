//
//  TabBarRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class TabBarRouter: TabBarViewRouter{

    private var tabBarView: UITabBarController?
    
    static func create() -> UITabBarController {
        
        let view = TabBarVC()
        let router = TabBarRouter()
        let presenter = TabBarPresenter(view: view , router: router)
        
        view.presenter = presenter
        router.tabBarView = view
        
        return view
    }
    
      func setupTabBarNavigation() {
        
        let homeVC = HomeRouter.create()
        let searchVC = SearchRouter.create()
        let favoritesVC = FavoritesRouter.create()
        
        let homeNavigation = UINavigationController(rootViewController: homeVC)
        let searchNavigation = UINavigationController(rootViewController: searchVC)
        let favoritesNavigation = UINavigationController(rootViewController: favoritesVC)
        
        homeNavigation.tabBarItem = UITabBarItem(title: "home", image: UIImage(systemName: "house.fill"), tag: 1)
        searchNavigation.tabBarItem = UITabBarItem(title: "search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        favoritesNavigation.tabBarItem = UITabBarItem(title: "favorites", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        
        homeNavigation.navigationBar.prefersLargeTitles = true
        searchNavigation.navigationBar.prefersLargeTitles = true
        favoritesNavigation.navigationBar.prefersLargeTitles = true
        
        tabBarView?.setViewControllers([homeNavigation, searchNavigation, favoritesNavigation], animated: true)
        
    }
}
