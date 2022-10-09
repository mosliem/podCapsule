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
 
    
    func moveToPlayerController(with episode: EpisodeObject){
        let vc = PlayerRouter.create(with: episode)
        vc.modalPresentationStyle = .overFullScreen
        searchView?.present(vc, animated: true)
    }
    
    
    func moveToPodcastDetailsController(with podcast: PodcastObject){
        let vc = PodcastDetailsRouter.create(with: podcast)
        searchView?.navigationController?.pushViewController(vc, animated: true)
    }
}
