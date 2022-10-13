//
//  PlayerRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/27/22.
//

import UIKit

class PlayerRouter{
    
    unowned var playerView: UIViewController?
    
    static func create(with episode: EpisodeObject?, playedDuration: Double? = 0) -> UIViewController{

        let view = PlayerVC()
        let router = PlayerRouter()
        let interactor = PlayerInteractor()
        let audioPlayer = AudioPlayer()
        var presenter: PlayerPresenter?
        
        if playedDuration == 0 {
             presenter = PlayerPresenter(view: view, interactor: interactor, router: router, episode: episode, audioPlayer: audioPlayer)
        }
        else{
            presenter = PlayerPresenter(view: view, interactor: interactor, router: router, episode: episode, audioPlayer: audioPlayer, playedDuration: playedDuration)
        }
        
        interactor.presenter = presenter
        view.presenter = presenter
        router.playerView = view
        audioPlayer.presenter = presenter
        
        return view
    }
    
}


extension PlayerRouter: PlayerViewRouter{
    
    func dismissPlayerVC() {
        playerView?.dismiss(animated: true, completion: nil)
    }
    
}
