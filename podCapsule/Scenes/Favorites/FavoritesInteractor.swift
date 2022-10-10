//
//  FavoritesInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import RealmSwift

class FavoritesInteractor: FavoritesInteractorInput{
    
    var presenter: FavoritesInteractorOutput?
    
    
    
    func getFavoritePodcasts() {
        
        RealmManager.shared.retrieveAllObjects(LovedPodcastModel.self) { (result) in
            
            switch result{
                case .success(let podcasts):
                    self.presenter?.success(with: podcasts as! [LovedPodcastModel])
                case .failure(let error):
                    self.presenter?.failed(with: (error as! RealmError).errorMessage)
            }
        }
    }
    
    func getFavoriteEpisodes() {
        
        RealmManager.shared.retrieveAllObjects(LovedEpisode.self) { (result) in
            
            switch result{
                case .success(let episodes):
                    self.presenter?.success(with: episodes as! [LovedEpisode])
                case .failure(let error):
                    self.presenter?.failed(with: (error as! RealmError).errorMessage)
            }
        }
        
    }
    
}
