//
//  SearchRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class SearchRouter {
    
    internal var SearchView: UIViewController?
    
    static func create() -> UIViewController {
        
        let view = SearchVC()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.SearchView = view
        
        return view
    }
}

extension SearchRouter: SearchViewRouter {
    
    func moveToSearchController() {
        let searchResult = SearchResultsVC()
        let view = UISearchController(searchResultsController: searchResult)
        view.definesPresentationContext = true
        view.searchResultsUpdater = searchResult
        SearchView?.present(view, animated: true, completion: nil)
    }
    
    
}
