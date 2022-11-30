//
//  TabBarRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class TabBarRouter: TabBarViewRouter{

    private weak var tabBarView: UITabBarController?
    
    static func create() -> UITabBarController {
        
        let view = TabBarVC()
        let router = TabBarRouter()
        let presenter = TabBarPresenter(view: view , router: router)
        
        view.presenter = presenter
        router.tabBarView = view
        
        return view
    }
    
      func setupTabBarNavigation() {
        
       let homeNav = setupHomeVC()
       let searchNav = setupSearchVC()
       let favoritesNav = setupFavoritesVC()
       tabBarView?.setViewControllers([homeNav, searchNav, favoritesNav], animated: true)
    }
    
    func setupSearchVC() -> UIViewController {

        let searchVC = SearchRouter.create()
        let searchNavigation = UINavigationController(rootViewController: searchVC)
        
        searchNavigation.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        searchNavigation.navigationBar.prefersLargeTitles = true
        let searchResultsVC = SearchResultsRouter.create()
        
        (searchVC as! SearchVC).searchController = UISearchController(searchResultsController: searchResultsVC)

        (searchVC as! SearchVC).searchController?.searchBar.delegate = searchResultsVC as? UISearchBarDelegate
        
        (searchResultsVC as! SearchResultsView).presenter?.delegate = (searchVC as! SearchView).presenter as? SelectedResultsCellProtocol
        
        return searchNavigation
    }
    
    func setupHomeVC() -> UIViewController{
        
        let homeVC = HomeRouter.create()
        let homeNavigation = UINavigationController(rootViewController: homeVC)
        
        homeNavigation.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        homeNavigation.navigationBar.prefersLargeTitles = true
        
        return homeNavigation
    }
    
    
    func setupFavoritesVC() -> UIViewController {
        let favoritesVC = FavoritesRouter.create()
        let favoritesNavigation = UINavigationController(rootViewController: favoritesVC)
        
        favoritesNavigation.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "bookmark.fill"), tag: 1)
        favoritesNavigation.navigationBar.prefersLargeTitles = true
        
        return favoritesNavigation
    }
}
