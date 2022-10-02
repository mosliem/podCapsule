//
//  HomeRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

class HomeRouter{
    
    var HomeView: UIViewController?
    
    static func create() -> UIViewController {
        
        let view = HomeVC()
        let networkInteractor = HomeNetworkInteractor()
        let localInteractor = HomeLocalInteractor()
        let router = HomeRouter()
        
        let presenter = HomePresenter(view: view, networkInteractor: networkInteractor, localInteractor: localInteractor, router: router)
        
        view.presenter = presenter
        networkInteractor.presenter = presenter
        localInteractor.presenter = presenter
        router.HomeView = view
        return view
    }
}

extension HomeRouter: HomeViewRouter {
    
    func moveToPlayer(with episode: EpisodeObject) {
        let playerVC = PlayerRouter.create(with: episode)
        playerVC.modalPresentationStyle = .overFullScreen
        HomeView?.present(playerVC, animated: true)
    }
    
    func moveToPodcastDetails(with podcast: HomePodcastResponse) {
        
    }
    
    
}
