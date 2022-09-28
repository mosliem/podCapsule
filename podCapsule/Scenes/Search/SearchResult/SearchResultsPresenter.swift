//
//  SearchResultsPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/11/22.
//

import Foundation

class SearchResultsPresenter: SearchResultsViewPresenter {
    
    weak var view: SearchResultsView?
    var router: SearchResultsViewRouter?
    var interactor: SearchResultsInteractorInput?
    
    private var episodeSearchResult = [EpisodeObject]()
    private var podcastSearchResult = [PodcastObject]()
    
    private var searchResultGroup = DispatchGroup()
    
    weak var delegate: SelectedResultsCellProtocol?
    
    required init(view: SearchResultsView, router: SearchResultsViewRouter, interactor: SearchResultsInteractorInput) {
        
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
//MARK:- Search for query
    
    func searchBarChanged(with text: String?) {
        
        guard let text = text else {
            return
        }
        
        view?.hideResultsTableView()
        view?.showLoadingIndicator()
          
        searchFor(query: text)
    }
    
    func typingStarted() {
        view?.hideNoResultsAnimation()
        view?.hideResultsTableView()
        view?.hideNoResultsLabel()
    }

    private func searchFor(query: String){
        
        let searchQueryType = ["podcast","episode"]
        
        for type in searchQueryType {
            searchResultGroup.enter()
            switch SearchQueryType.ObjectForType(type: type) {
            
            case .podcast:
                interactor?.search(for: query, type: type, sortByDate: true, objectType: PodcastSearchResponse.self)
                
            case .episode:
                interactor?.search(for: query, type: type, sortByDate: true, objectType: EpisodeSearchResponse.self)
            }
        }
        
        searchResultGroup.notify(queue: .main){
            self.didGetSearchResult()
        }
    }
    
    private func didGetSearchResult(){
        
        if !podcastSearchResult.isEmpty || !episodeSearchResult.isEmpty{
            view?.reloadTableDate()
            view?.hideLoadingIndicator()
            view?.showResultsTableView()
            view?.hideNoResultsLabel()
            view?.hideNoResultsAnimation()
        }
        else{
            
            view?.hideLoadingIndicator()
            view?.hideResultsTableView()
            view?.showNoResultsLabel()
            view?.showNoResultsAnimation()
        }
    }
    
}

//MARK:- Table view information
extension SearchResultsPresenter{
    func numberOfSection() -> Int{
        return 2
    }
    
    func itemsForSection(for section: Int) -> Int {
        
        switch  SearchResultsSections.typeForSection(index: section){
        case .Podcasts:
            return podcastSearchResult.count
            
        case .Episodes:
            return episodeSearchResult.count
        }
    }
    
    func titleForSection(for section: Int) -> String{
        return SearchResultsSections.titleForSection(index: section)
    }
    
    func cellTypeForSection <T> (for section: Int) -> T {
        
        switch SearchResultsSections.typeForSection(index: section){
        case .Podcasts:
            return PodcastResultsTableViewCell.self as! T
            
        case .Episodes:
            return EpisodeResultsTableViewCell.self as! T
            
        }
    }
    
    func selectCell(for section: Int, at indexPath: Int) {
        
        view?.deselectCell()
        
        switch SearchResultsSections.typeForSection(index: section) {
           
            case .Podcasts:
                delegate?.didSelectPodcast(podcast: podcastSearchResult[indexPath])
            
            case .Episodes:
                delegate?.didSelectEpisode(episode: episodeSearchResult[indexPath])
        }
    }
}

//MARK:- Configure Table View Cells
extension SearchResultsPresenter{
    
    func configureCell <T>(for section: Int, at indexPath: Int, cell: T) {
        
        switch SearchResultsSections.typeForSection(index: section){
        
        case .Podcasts:
            let cellData = podcastSearchResult[indexPath]
            configurePodcastCell(cellData: cellData, cell: cell as! PodcastResultsTableCellView)
            
        case .Episodes:
            let cellData = episodeSearchResult[indexPath]
            configureEpisodeCell(cellData: cellData, cell: cell as! EpisodeResultsTableCellView)
        }
        
    }
    
    private func configurePodcastCell(cellData: PodcastObject, cell: PodcastResultsTableCellView){
        
        if let imageURL = URL(string: cellData.image ){
            cell.displayImage(with: imageURL)
        }
        else{
            cell.displayDefaultImage()
        }
        
        cell.displayPublisher(publisher: cellData.publisher)
        cell.displayTitle(title: cellData.title)
        
        
        guard let genreId = cellData.genre_ids?.first else{
            return
        }
        
        if categoryName[genreId] != nil, let genreName = categoryName[genreId] {
            cell.displayGenre(genre: genreName)
        }
    }
    
    
    private func configureEpisodeCell(cellData: EpisodeObject, cell: EpisodeResultsTableCellView){
        
        if let imageURL = URL(string: cellData.image ){
            cell.displayImage(with: imageURL)
        }
        else{
            cell.displayDefaultImage()
        }
        
        if let publisher = cellData.podcast?.publisher {
            cell.displayPublisher(publisher: publisher )
        }
        let duration = convertSecToDuration(sec: cellData.audio_length_sec)
        cell.displayDuration(duration: duration)
        
        
        cell.displayTitle(title: cellData.title)
    }
    
    private func convertSecToDuration(sec: Int) -> String{
        return "\(sec / 60)min"
    }
}

//MARK:- Interactor Results
extension SearchResultsPresenter: SearchResultsInteractorOutput{
    
    func success(with results: EpisodeSearchResponse) {
        defer{
            searchResultGroup.leave()
        }
        episodeSearchResult = results.results
    }
    
    func success(with results: PodcastSearchResponse) {
        defer{
            searchResultGroup.leave()
        }
        podcastSearchResult = results.results
    }
    
    func failed(with error: Error) {
        
        defer{
            searchResultGroup.leave()
        }
        
        view?.hideResultsTableView()
        view?.hideLoadingIndicator()
        
        view?.showErrorAlert(title: "Error", message: "Something went wrong!")
    }
    
}


