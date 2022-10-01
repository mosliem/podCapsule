//
//  PlayerInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/27/22.
//

import Foundation

class PlayerInteractor: PlayerInteractorInput{
    
    weak var presenter: PlayerInteractorOutput?
    
    func addNew(recentlyPlayed episode: RecentlyPlayedEpisodeModel) {
        
        RealmManager.shared.add(object: episode) { (result) in
            
            switch result {
                case .success(_):
                    break
                case .failure(let error):
                    self.presenter?.failed(with: (error as! RealmError).errorMessage)
            }
        }
    }
    
    func addToLovedList(lovedEpisode: LovedEpisode) {
        
        RealmManager.shared.add(object: lovedEpisode) { (result) in
            
            switch result {
                case .success(_):
                    break
                case .failure(let error):
                    self.presenter?.failed(with: (error as! RealmError).errorMessage)
            }
        }
        
    }
    
    func removeFromLovedList(id: String, type: LovedEpisode.Type ){
        
        RealmManager.shared.deleteObject(with: id, type: type) { (result) in
            
            switch result {
                case .success(_):
                    break
                case .failure(let error):
                    self.presenter?.failed(with: (error as! RealmError).errorMessage)
            }
        }
    }
    
    func isExistInLovedList(id: String) {
        
        RealmManager.shared.checkIfExist(with: id, type: LovedEpisode.self) { (exist) in
            self.presenter?.existedInLovedList(existed: exist)
        }

    }
}
