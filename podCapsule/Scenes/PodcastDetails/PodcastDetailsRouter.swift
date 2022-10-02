//
//  PodcastDetailsRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import UIKit


class PodcastDetailsRouter {
    
    var podcastDetailsView: PodcastDetailsVC?
    
    static func create(with podcast: PodcastObject) -> UIViewController{
        
        let view = PodcastDetailsVC()
        let interactor = PodcastDetailsInteractor()
        let router = PodcastDetailsRouter()
        
        let presenter = PodcastDetailsPresenter(view: view, router: router, interactor: interactor, podcast: podcast)
        
        view.presenter = presenter
        interactor.presenter = presenter
        router.podcastDetailsView = view
        
        return view
    }
    
    
}

extension PodcastDetailsRouter: PodcastDetailsViewRouter {
    
}
