//
//  SearchPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

class SearchPresenter: SearchViewPresenter {
  
    weak var view: SearchView?
    var interactor: SearchInteractorInput?
    var router: SearchViewRouter?
    
    private var suggestions = [HomePodcastResponse]()
    
    required init(view: SearchView, interactor: SearchInteractorInput, router: SearchViewRouter) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func viewDidLoad() {
        let random = Int.random(in: 1...10)
//        interactor?.fetchSuggestedPodcast(pageNumber: random)
    }
    
    func suggestedPodcastCount() -> Int {
        return suggestions.count
    }
    
    func searchPressed() {
        router?.moveToSearchResultController()
    }
    
    func configure(for cell: SuggestedPodcastsCellView, at indexPath: Int){
         
        let cellData = suggestions[indexPath]
        
        if let imageURL = URL(string: cellData.image ?? ""){
            cell.displayPodcastPoster(imageUrl: imageURL)
        }
        
        cell.displayTitle(podcastTitle: cellData.title )
        cell.displayPublisherName(publisher: cellData.publisher )
    }
    
    func tableScrolled(with offset: Float) {
        
        if offset > 0 {
            view?.hideNavigationBar()
        }
        else{
            view?.showNavigationBar()
        }
    }
    
    func cellSelected(at indexPath: Int) {
        
    }
    
}

extension SearchPresenter: SearchInteractorOutput{
    
    func success(with suggestedPodcasts: PopularPodcasts) {
        
        for podcast in suggestedPodcasts.curated_lists{
            suggestions.append(contentsOf: podcast.podcasts)
        }
        
        view?.reloadsuggestedData()
    }
    
    func failed(with error: Error) {
        print(error.localizedDescription)
    }
}


// delegate functions of search results controller

extension SearchPresenter: SelectedResultsCellProtocol{
    
    func didSelectEpisode(episode: EpisodeObject) {
        router?.moveToPlayerController(with: episode)
    }
    
    func didSelectPodcast(podcast: PodcastObject) {
        router?.moveToPodcastDetailsController(with: podcast)
    }
    
}
