//
//  PodcastDetailsProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import Foundation


protocol PodcastDetailsView: class {
    
    var presenter: PodcastDetailsViewPresenter? { get set }
    
}

protocol PodcastDetailsViewPresenter: class {
    
    var view: PodcastDetailsView? { get set }
    var router: PodcastDetailsViewRouter? { get set }
    var podcast: PodcastObject? { get set }

    init(view: PodcastDetailsView?, router: PodcastDetailsViewRouter?, interactor: PodcastDetailsInteractorInput?, podcast: PodcastObject)
    
    
}

protocol PodcastDetailsInteractorInput: class {
    
    var presenter: PodcastDetailsInteractorOutput? { get set }
}

protocol PodcastDetailsInteractorOutput: class {
    
    var interactor: PodcastDetailsInteractorInput? { get set }
}

protocol PodcastDetailsViewRouter: class {

}

