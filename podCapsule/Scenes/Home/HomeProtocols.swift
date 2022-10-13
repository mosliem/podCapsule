//
//  HomeProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

protocol HomeView: class {
    
    var presenter: HomeViewPresenter? { get set }
    
    func reloadHomeCollectionView()

    func addRecentlyPlayedSection()
    func addPodcastSection()
    func assignCollectionViewLayout()
    func showLoader()
    func hideLoader()
}

protocol HomeViewPresenter: class {
    
    var view: HomeView? { get set }
    var router: HomeViewRouter? { get set }
    
    init(view: HomeView, networkInteractor: HomeNetworkInteractorInputProtocol, localInteractor: HomeLocalInteractorInput, router: HomeViewRouter)
    func viewDidLoad()
    func viewWillAppear()
    func numberOfSections() -> Int
    func itemsForSection(for section: Int) -> Int
    func titleForSection(for section: Int, header: SectionsCollectionReusableViewInput)
   
    func cellType<T>(for section: Int) -> T
    
    func configureCell<T> (at section: Int, for indexPath: Int, cell: T)
   
    func cellSelected(at section: Int, row: Int)
}


protocol HomeNetworkInteractorInputProtocol: class {
    
    var presenter: HomeNetworkInteractorOutputProtocol? { get set }
    func fetchPopularPodcast()
    func fetchRandomEpisodes()
    func fetchBestForCategory(genre_id: Int, pageNum: Int, region: String)
    
}

protocol HomeNetworkInteractorOutputProtocol: class {
    
    var networkInteractor: HomeNetworkInteractorInputProtocol? { get set }
    
    func popularPodcastFetched(podcasts: PopularPodcasts)
    func randomEpisodesFetched(episodes: [RandomEpisodesResponse])
    func bestForCategoryFetched(podcasts: BestPodcastsObject)
    func failedWith(with error: Error)
    
}

protocol HomeLocalInteractorInput: class {
    
    var presenter: HomeLocalInteractorOutput? { get set }
    
    func getCategories()
    func getRegion()
    func getRecentlyPlayed()

}

protocol HomeLocalInteractorOutput: class {
    
    var localInteractor: HomeLocalInteractorInput? { get set }
    
    func success(with categories: [CategoryModel])
    func success(with country: String)
    func success(with recentlyPlayed: [RecentlyPlayedEpisodeModel])
    func failed(with error: Error)
    
}

protocol HomeViewRouter: class {
    
    func moveToPlayer(with recentlyPlayed: EpisodeObject, playedDuration: Double?)
    func moveToPlayer(with episode: EpisodeObject)
    func moveToPodcastDetails(with podcast: PodcastObject)
}

protocol RecentlyPlayedCellView: class {
    
    func displayPosterImage(url: URL?)
    func displayDefualtPoster(string: String)
    func displayName(for episode: String)
    func displayRemainingTime(time: String)
    
}

protocol PodcastCellView: class {
    
    func displayPosterImage(urlString: String)
    func displayName(for episode: String)

}
