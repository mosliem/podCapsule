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
        
//        let endpoint =
        
        NetworkManger.shared.callRequest(objectType: PopularPodcasts.self, endpoint: HomeRequest.fetchPopularPodcastsList(pageNumber: 1) ) { [weak self] (result) in
            
            switch result {
            
            case .success(let model):
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
        
        for _ in 0 ..< 5 {
            
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
    
    func fetchBestForCategory(genre_id: Int, pageNum: Int, region: String){
        
        let endpoint = HomeRequest.fetchBestForCategory(genre_id: genre_id, pageNum: pageNum, region: region)
        NetworkManger.shared.callRequest(objectType: BestPodcastsObject.self, endpoint: endpoint ) {[weak self] (result) in
            
            switch result {
            case .success(let podcasts):
                print(podcasts.name, podcasts.podcasts.count)
                self?.presenter?.bestForCategoryFetched(podcasts: podcasts)
                
            case .failure(let error):
                self?.presenter?.failedWith(with: error)
            }
        }
    }
    
}
