//
//  NetworkInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/6/22.
//

import Foundation

class HomeNetworkInteractor: HomeNetworkInteractorInputProtocol {
    
    
    weak var presenter: HomeNetworkInteractorOutputProtocol?
    
    func fetchPopularPodcast() {
        
        NetworkManger.shared.callRequest(objectType: PopularPodcasts.self, endpoint: HomeRequest.fetchPopularPodcastsList(pageNumber: 1)) { [weak self] (result) in
            
            switch result {
            
            case .success(let model):
                print(model)
                var popularPodcasts: [PodcastObject] = []
                
                for podcasts in model.curated_lists {
                    
                    for podcast in podcasts.podcasts{
                        
                        popularPodcasts.append(podcast)
                    }
                }
                self?.presenter?.popularPodcastFetched(podcasts: popularPodcasts)
                
            case .failure(let error):
                self?.presenter?.failedWith(with: error)
                
            }
        }
    }
    
    
    func fetchRandomEpisodes() {
        
        var episodeList = [EpisodeObject]()
        let group = DispatchGroup()
        
        for _ in 0 ..< 15 {
            
            group.enter()
            
            NetworkManger.shared.callRequest(objectType: EpisodeObject.self, endpoint: HomeRequest.fetchRandomEpisode) {[weak self] (result) in
                
                defer {
                    group.leave()
                }
                
                switch result {
                
                case .success(let episode):
                    episodeList.append(episode)
                case .failure(let error):
                    self?.presenter?.failedWith(with: error)
                }
                
            }
        }
        
        group.notify(queue: .main){
            self.presenter?.randomEpisodesFetched(episodes: episodeList)
        }
    }
    
}
