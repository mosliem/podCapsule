//
//  SearchResultsProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/11/22.
//

import Foundation


protocol SearchResultsView: class {
    
    var presenter: SearchResultsViewPresenter? { get set }
    
    func reloadTableDate()
    func showLoadingIndicator()
    func hideLoadingIndicator()
    
    func hideResultsTableView()
    func showResultsTableView()
    
    func showNoResultsLabel()
    func hideNoResultsLabel()
    
    func showNoResultsAnimation()
    func hideNoResultsAnimation()
    
    func deselectCell()
    func showErrorAlert(title: String, message: String)
}

protocol EpisodeResultsTableCellView: class {
    
    func displayTitle(title: String)
    func displayPublisher(publisher: String)
    func displayDuration(duration: String)
    func displayImage(with url: URL)
    func displayDefaultImage()
}

protocol PodcastResultsTableCellView: class {
    
    func displayTitle(title: String)
    func displayPublisher(publisher: String)
    func displayGenre(genre: String)
    func displayImage(with url: URL)
    func displayDefaultImage()

}

protocol SearchResultsViewPresenter: class {
    
    var view: SearchResultsView? { get set }
    var router: SearchResultsViewRouter? { get set }
    var delegate: SelectedResultsCellProtocol? { get set }

    
    init(view: SearchResultsView, router: SearchResultsViewRouter, interactor: SearchResultsInteractorInput)
    func searchBarChanged(with text: String?)
    
    func numberOfSection() -> Int
    func titleForSection(for section: Int) -> String
    func itemsForSection(for section: Int) -> Int
    
    func configureCell <T>(for section: Int, at indexPath: Int, cell: T)
    func cellTypeForSection <T> (for section: Int) -> T
    func selectCell(for section: Int, at indexPath: Int)
    
    func typingStarted()
}

protocol SearchResultsViewRouter: class {
    func dismissView()
}

protocol SearchResultsInteractorInput: class {
    
    var presenter: SearchResultsInteractorOutput? { get set }
    func search <T: Codable> (for query: String, type: String, sortByDate: Bool, objectType: T.Type)
    
}

protocol SearchResultsInteractorOutput: class {
    
    var interactor: SearchResultsInteractorInput? { get set }
    func success(with results: EpisodeSearchResponse)
    func success(with results: PodcastSearchResponse)
    func failed(with error: Error)
}


protocol SelectedResultsCellProtocol: class {
    
    func didSelectEpisode(episode: EpisodeObject)
    func didSelectPodcast(podcast: PodcastObject)

}
