//
//  PlayerRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/27/22.
//

import UIKit

class PlayerRouter{
    
    weak var playerView: UIViewController?
    
    static func create(with episode: EpisodeObject?) -> UIViewController{

        let view = PlayerVC()
        let router = PlayerRouter()
        let interactor = PlayerInteractor()
        let audioPlayer = AudioPlayer()
        let presenter = PlayerPresenter(view: view, interactor: interactor, router: router, episode: episode, audioPlayer: audioPlayer)
        
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
