//
//  FavoritesProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

protocol FavoritesView: class  {
    var presenter: FavoritesViewPresenter? { get set }
}

protocol FavoritesViewPresenter: class{
    
    var view: FavoritesView? { get set }
    var interactor: FavoritesInteractorInput? { get set }
    var router: FavoritesViewRouter? { get set }
    
    init(view: FavoritesView, interactor: FavoritesInteractorInput, router: FavoritesViewRouter)
}

protocol FavoritesViewRouter: class {
    
}

protocol FavoritesInteractorInput: class {
    
    var presenter: FavoritesInteractorOutput? { get set }
    
}

protocol FavoritesInteractorOutput: class {
    
}
