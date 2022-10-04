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
    
    //for the particular case of continuing playing at a specific time of the recently played episode
    func moveToPlayer(with recentlyPlayed: EpisodeObject, playedDuration: Double?){
        let playerVC = PlayerRouter.create(with: recentlyPlayed, playedDuration: playedDuration)
        playerVC.modalPresentationStyle = .overFullScreen
        (playerVC as! PlayerView).presenter?.playerView = (HomeView as! HomeView).presenter as? PlayerViewDelegate
        HomeView?.present(playerVC, animated: true)
    }
    
    func moveToPlayer(with episode: EpisodeObject) {
        let playerVC = PlayerRouter.create(with: episode)
        playerVC.modalPresentationStyle = .overFullScreen
        (playerVC as! PlayerView).presenter?.playerView = (HomeView as! HomeView).presenter as? PlayerViewDelegate 
        HomeView?.present(playerVC, animated: true)
    }
    
    func moveToPodcastDetails(with podcast: PodcastObject) {
        let podcastDetailsVC = PodcastDetailsRouter.create(with: podcast)
        podcastDetailsVC.navigationItem.largeTitleDisplayMode = .never
        HomeView?.navigationController?.pushViewController(podcastDetailsVC, animated: true)
    }
    
    
}
