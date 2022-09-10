//
//  FavoritesPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

class FavoritesPresenter: FavoritesViewPresenter{
    
    var view: FavoritesView?
    
    var interactor: FavoritesInteractorInput?
    
    var router: FavoritesViewRouter?
    
    required init(view: FavoritesView, interactor: FavoritesInteractorInput, router: FavoritesViewRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    
}

extension FavoritesPresenter: FavoritesInteractorOutput{
    
}
