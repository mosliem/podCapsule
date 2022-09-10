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

}

protocol HomeViewPresenter: class {
    
    var view: HomeView? { get set }
    
    init(view: HomeView?, networkInteractor: HomeNetworkInteractorInputProtocol?, localInteractor: HomeLocalInteractorInput)
    func viewDidLoad()
    
    func numberOfSections() -> Int
    func itemsForSection(for section: Int) -> Int
    func titleForSection(for section: Int, header: HomeCollectionReusableViewInput)
    func configureCell<T> (at section: Int, for indexPath: Int, cell: T)
    func heightForRecentlyPlay() -> Double
    
}


protocol HomeNetworkInteractorInputProtocol: class {
    
    var presenter: HomeNetworkInteractorOutputProtocol? { get set }
    func fetchPopularPodcast()
    func fetchRandomEpisodes()
}

protocol HomeNetworkInteractorOutputProtocol: class {
    
    var networkInteractor: HomeNetworkInteractorInputProtocol? { get set }
    func popularPodcastFetched(podcasts: [PodcastObject])
    func randomEpisodesFetched(episodes: [EpisodeObject])
    func failedWith(with error: Error)
    
}

protocol HomeLocalInteractorInput: class {
    
    var presenter: HomeLocalInteractorOutput? { get set }
    
    func getCategories()
    
}

protocol HomeLocalInteractorOutput: class {
    
    var localInteractor: HomeLocalInteractorInput? { get set }
    
    func success(with categories: [CategoryModel])
    func failed(with error: Error)
    
}

protocol HomeCollectionReusableViewInput: class  {
    
    func dispalySectionTitle(text: String)
}

protocol RecentlyPlayedCellView: class {
    
    func displayPosterImage(urlString: String?)
    func displayName(for episode: String)
    func displayRemainingTime(time: String)
    
}

protocol PodcastCellView: class {
    
    func displayPosterImage(urlString: String)
    func displayName(for episode: String)

}
