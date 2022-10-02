//
//  PodcastDetailsPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import Foundation

class PodcastDetailsPresenter: PodcastDetailsViewPresenter {
    
    var view: PodcastDetailsView?
    var router: PodcastDetailsViewRouter?
    var interactor: PodcastDetailsInteractorInput?
    var podcast: PodcastObject?
    
    required init(view: PodcastDetailsView?, router: PodcastDetailsViewRouter?, interactor: PodcastDetailsInteractorInput?, podcast: PodcastObject) {
        
        self.view = view
        self.router = router
    }
    
    
}

extension PodcastDetailsPresenter: PodcastDetailsInteractorOutput {
    
}
