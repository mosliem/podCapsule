//
//  FavoritesRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class FavoritesRouter {
    
    unowned var favoritesView: UIViewController?
    
    static func create() -> UIViewController {
        
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
    
    func moveToPodcastDetails(with podcast: PodcastObject){
        let vc = PodcastDetailsRouter.create(with: podcast)
        favoritesView?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToAudioPlayer(with episode: EpisodeObject){
        let vc = PlayerRouter.create(with: episode)
        vc.modalPresentationStyle = .overFullScreen
        (vc as! PlayerView).presenter?.playerView = (favoritesView as! FavoritesView).presenter as? PlayerViewDelegate
        favoritesView?.present(vc, animated: true)
    }
}
