//
//  PreferencesRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/8/22.
//

import UIKit
import SKCountryPicker

class PreferencesRouter {
    
    internal var view: UIViewController?

    static func create() -> UIViewController {
        
        let view = PreferencesVC()
        let interactor = PreferencesInteractor()
        let router = PreferencesRouter()
        
        let presenter = PreferencesPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        
        let navController = UINavigationController(rootViewController: view)
        view.navigationController?.navigationBar.isHidden = true
        return navController
    }
}

extension PreferencesRouter: PreferencesViewRouter{
  
    func viewCountryPickerVC() {
    
        CountryPickerController.presentController(on: view! , configuration: { countryController in
           
            countryController.delegate = view as? CountryPickerDelegate
            countryController.configuration.flagStyle = .corner
            countryController.configuration.isCountryFlagHidden = false
            countryController.configuration.isCountryDialHidden = true
            countryController.title = "Select a country"
            
        })
    }
    
    func viewCategoriesInterest() {
        
        let categoriesView = CategoriesInterestRouter.create()
        
        // Setting categoriesSelectionDelegate
        (categoriesView as? CategoriesInterestView)?.presenter?.categoryDelegate = (view as? PreferencesView)?.presenter as? CategoriesSelectionDelegate
        
        categoriesView.title = "Categories"
        view?.navigationController?.pushViewController(categoriesView, animated: true)
    }
    
    func viewTabBar(){
        
        let tabBar = TabBarRouter.create()
//        TabBarRouter.setupTabBarNavigation()
        view?.navigationController?.pushViewController(tabBar, animated: true)
    }
  
}
