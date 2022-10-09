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
        view?.showLoadingIndicator()
        let random = Int.random(in: 1...10)
        interactor?.fetchSuggestedPodcast(pageNumber: random)
    }
    
    func suggestedPodcastCount() -> Int {
        return suggestions.count
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
        
        let selectedPodcast = convert(to: PodcastObject.self, object: suggestions[indexPath])
        router?.moveToPodcastDetailsController(with: selectedPodcast)
    }
    
    func convert(to type: PodcastObject.Type, object: HomePodcastResponse) -> PodcastObject{
        
        var convertedObject: PodcastObject
        
        convertedObject = PodcastObject(id:object.id , title: object.title, publisher: object.publisher, image: object.image, description: nil, total_episodes: nil, genre_ids: nil, listennotes_url: object.listennotes_url)
        
        return convertedObject
    }
}

extension SearchPresenter: SearchInteractorOutput{
    
    func success(with suggestedPodcasts: PopularPodcasts) {
        
        for podcast in suggestedPodcasts.curated_lists{
            suggestions.append(contentsOf: podcast.podcasts)
        }
        
        view?.reloadsuggestedData()
        view?.hideLoadingIndicator()
    }
    
    func failed(with error: Error) {
        view?.hideLoadingIndicator()
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

