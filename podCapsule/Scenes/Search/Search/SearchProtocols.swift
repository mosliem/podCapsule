//
//  SearchProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

protocol SearchView: class {
    var presenter: SearchViewPresenter? { get set }
}

protocol SearchViewPresenter: class {
    
    var view: SearchView? { get set }
    var interactor: SearchInteractorInput? { get set }
    var router: SearchViewRouter? { get set }
    
    init(view: SearchView, interactor: SearchInteractorInput, router: SearchViewRouter)
    
    func searchPressed()
}

protocol SearchViewRouter: class {
    
    func moveToSearchController()
}

protocol SearchInteractorInput: class {
    var presenter: SearchInteractorOutput? { get set }
}

protocol SearchInteractorOutput: class {
    
}
