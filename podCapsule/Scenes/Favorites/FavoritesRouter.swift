//
//  FavoritesRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class FavoritesRouter {
    
    internal var favoritesView: UIViewController?
    
    static func create() -> UIViewController{
        
        let view = FavoritesVC()
        let interactor = FavoritesInteractor()
        let router = FavoritesRouter()
        let sectionHandler = FavoriteSectionsHandler()
        
        let presenter = FavoritesPresenter(view: view, interactor: interactor, router: router, sectionsHandler: sectionHandler)
        
        view.presenter = presenter
        router.favoritesView = view
        interactor.presenter = presenter
        
        return view
    }
    
}


extension FavoritesRouter: FavoritesViewRouter{
    
}
