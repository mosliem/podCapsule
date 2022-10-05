//
//  PodcastDetailsProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import UIKit


protocol PodcastDetailsView: class {
    
    var presenter: PodcastDetailsViewPresenter? { get set }
    
    func updateScrollViewHeight()
    
    func displayPodcastPoster(with url: URL?)
    func displayPodcastTitle(title: String)
    func displayPodcastPublisher(publisher: String)
    func displayPodcastDescription(description: String)
    func displayEpisodeNumber(number: String)
    
    func showLoader()
    func hideLoader()
    
    func reloadEpisodesTableView()
    
    func showErrorAlert(title: String, message: String, actionTitle: String, actionHandler: @escaping ((UIAlertAction)?) -> ())
}

protocol PodcastDetailsViewPresenter: class {
    
    var view: PodcastDetailsView? { get set }
    var router: PodcastDetailsViewRouter? { get set }
    var podcast: PodcastObject? { get set }

    init(view: PodcastDetailsView?, router: PodcastDetailsViewRouter?, interactor: PodcastDetailsInteractorInput?, podcast: PodcastObject)
    
    func viewDidLoad()
    
    func tableViewCount() -> Int
    func configureCell(at indexPath: Int)
    
}

protocol PodcastDetailsInteractorInput: class {
    
    var presenter: PodcastDetailsInteractorOutput? { get set }
    
    func getPodcastDetails(with id: String, sort: String)
    
}

protocol PodcastDetailsInteractorOutput: class {
    
    var interactor: PodcastDetailsInteractorInput? { get set }
    
    func success(with podcastDetails: PodcastDetailsObject)
    func failed(with error: Error)
}

protocol PodcastDetailsViewRouter: class {

}

