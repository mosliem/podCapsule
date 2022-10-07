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

    func updateLovedImage(with named: String)
    func updateNormalLovedTint()
    func updateSelectedLovedTint()
}

protocol PodcastDetailsViewPresenter: class {
    
    var view: PodcastDetailsView? { get set }
    var router: PodcastDetailsViewRouter? { get set }
    var podcast: PodcastObject? { get set }
    var podcastViewDelegate: PodcastViewDelegate? { get set }

    init(view: PodcastDetailsView?, router: PodcastDetailsViewRouter?, interactor: PodcastDetailsInteractorInput?, podcast: PodcastObject, localInteractor: PodcastDetailsLocalInteractorInput?)
    
    func viewDidLoad()
    
    func tableViewCount() -> Int
    func configureCell(at indexPath: Int, for cell: PodcastDetailsEpisodesCellProtocol)
    
    func didSelectCell(at indexPath: Int)
    
    func lovePressed()
    func sharePressed()
    
    func viewWillDisapear()
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

protocol PodcastDetailsLocalInteractorInput: class  {
    
    var presenter: PodcastDetailsLocalInteractorOutput? { get set }
    
    func addPodcastToLovedPodcast<T> (type: T.Type, object: T)
    func removePodcastFromLovedPodcast<T>(type: T.Type, id: String)
    func isExistInLovedList(id: String)
}

protocol PodcastDetailsLocalInteractorOutput: class {
    
    var localInteractor: PodcastDetailsLocalInteractorInput? { get set }
    
    func success(with process: Bool)
    func error(with message: String)
    func existedInLovedList(existed: Bool)

}

protocol PodcastDetailsViewRouter: class {
    func moveToPlayer(with episode: EpisodeObject)
    func popViewController()
    func viewActivityVC(with url: URL)
}

protocol PodcastDetailsEpisodesCellProtocol: class {
    
    func displayEpisodeImage(with url: URL?)
    func displayEpisode(title: String)
}


protocol PodcastViewDelegate: class {
    func podcastViewWillDisappear()
}
