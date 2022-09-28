//
//  SearchRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class SearchRouter {
    
    internal var searchView: UIViewController?
    
    static func create() -> UIViewController {
        
        let view = SearchVC()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.searchView = view
        
        return view
    }
}

extension SearchRouter: SearchViewRouter {
    
    func moveToSearchResultController() {
        
        let searchResult = SearchResultsRouter.create()
        let searchController = UISearchController(searchResultsController: searchResult)
        
        searchController.searchBar.barTintColor = .white
        searchController.view.backgroundColor = .white
        
        searchController.searchBar.delegate = searchResult as? UISearchBarDelegate
        
        // delegate for a result is selected
        (searchResult as? SearchResultsView)?.presenter?.delegate = (searchView as? SearchView)?.presenter as? SelectedResultsCellProtocol
        
        searchView?.present(searchController, animated: true, completion: nil)
    }
    
    
    func moveToPlayerController(with episode: EpisodeObject){
        let vc = PlayerRouter.create(with: episode)
        vc.modalPresentationStyle = .overFullScreen
        searchView?.present(vc, animated: true)
    }
    
    
    func moveToPodcastDetailsController(with podcast: PodcastObject){
        print("podcast")
    }
}
