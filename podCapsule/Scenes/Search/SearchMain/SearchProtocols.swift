//
//  SearchProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

protocol SearchView: class {
    
    var presenter: SearchViewPresenter? { get set }
    
    func hideNavigationBar()
    func showNavigationBar()
    func reloadsuggestedData()
    func showLoadingIndicator()
    func hideLoadingIndicator()
}

protocol SearchViewPresenter: class {
    
    var view: SearchView? { get set }
    var interactor: SearchInteractorInput? { get set }
    var router: SearchViewRouter? { get set }
    
    init(view: SearchView, interactor: SearchInteractorInput, router: SearchViewRouter)
    func viewDidLoad()
    func suggestedPodcastCount() -> Int

    func tableScrolled(with offset: Float)
    func configure(for cell: SuggestedPodcastsCellView, at indexPath: Int)
    func cellSelected(at indexPath: Int)
}

protocol SearchViewRouter: class {
    
    func moveToPlayerController(with episode: EpisodeObject)
    func moveToPodcastDetailsController(with podcast: PodcastObject)
}

protocol SearchInteractorInput: class {
    var presenter: SearchInteractorOutput? { get set }
    func fetchSuggestedPodcast(pageNumber: Int)
}

protocol SearchInteractorOutput: class {
    
    func success(with suggestedPodcasts: PopularPodcasts)
    func failed(with error: Error)
}

protocol SuggestedPodcastsCellView: class {
    func displayTitle(podcastTitle: String)
    func displayPodcastPoster(imageUrl: URL)
    func displayPublisherName(publisher: String)
}
