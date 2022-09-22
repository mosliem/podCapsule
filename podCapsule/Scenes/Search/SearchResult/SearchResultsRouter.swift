//
//  SearchResultsRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/11/22.
//

import UIKit

class SearchResultsRouter {
    
    internal var SearchResultView: UIViewController?
    
    static func create() -> UIViewController{
        
        let view = SearchResultsVC()
        let router = SearchResultsRouter()
        let interactor = SearchResultsInteractor()
        let presenter = SearchResultsPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        return view
    }
    
}

extension SearchResultsRouter: SearchResultsViewRouter{
    
    func moveToPodcastDetails(with podcast: PodcastResponse) {
    
    }
    
    func moveToEpisodePlayer(with episode: EpisodeResponse){
        
    }
    
    
}
