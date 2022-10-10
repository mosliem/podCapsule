//
//  FavoritesProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

protocol FavoritesView: class  {
    var presenter: FavoritesViewPresenter? { get set }
    
    func reloadFavoritesData()
    func showLoader()
    func hideLoader()
    
    func appendPodcastSectionLayout()
    func appendEpisodeSectionLayout()
    
    func setCollectionSectionsLayout()
    func showErrorAlert(title: String, message: String, actionTitle: String, actionHandler: @escaping (UIAlertAction?) -> ())
}

protocol FavoritesViewPresenter: class{
    
    var view: FavoritesView? { get set }
    var router: FavoritesViewRouter? { get set }
    var sectionsHandler: FavoriteSectionsHandler? { get set }
    
    init(view: FavoritesView, interactor: FavoritesInteractorInput, router: FavoritesViewRouter, sectionsHandler: FavoriteSectionsHandler?)
    
    func viewWillAppear()
    func numberOfSection() -> Int
    
    func type<T>(for section: Int) -> T
    func numberOfItems(for section: Int) -> Int
    func configureCell<T>(cell: T, type: T.Type)
    
    func cellSelected(at section: Int, for indexPath: Int)
}

protocol FavoritesViewRouter: class {
    
}

protocol FavoritesInteractorInput: class {
    
    var presenter: FavoritesInteractorOutput? { get set }
    
    func getFavoritePodcasts()
    func getFavoriteEpisodes()
    
}

protocol FavoritesInteractorOutput: class {
    var interactor: FavoritesInteractorInput? { get set }
    
    func success(with podcasts: [LovedPodcastModel])
    func success(with episodes: [LovedEpisode])
    
    func failed(with error: String)
}


protocol FavoritePodcastCellView: class {
    
    func displayPodcastImage(imageURL: URL?)
    func displayPodcastTitle(title: String)
}

protocol FavoriteEpisodeCellView {
    
    func displayEpisodeImage(with imageURL: URL?)
    func displayEpisodePublisher(publisher: String)
    func displayEpisodeTitle(title: String)
    func displayDuraion(duration: String)
}
