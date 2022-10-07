//
//  PodcastDetailsLocalInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/7/22.
//

import RealmSwift

class PodcastDetailsLocalInteractor: PodcastDetailsLocalInteractorInput{
        
    var presenter: PodcastDetailsLocalInteractorOutput?
    
    func addPodcastToLovedPodcast<T>(type: T.Type, object: T) {
        
        RealmManager.shared.add(object: object as! Object) {[weak self] (result) in
            
            switch result{
                case .success(let success):
                    self?.presenter?.success(with: success)
                case .failure(let error):
                    self?.presenter?.error(with: (error as! RealmError).errorMessage)
            }
        }
    }
    
    func removePodcastFromLovedPodcast<T>(type: T.Type, id: String) {
        
        RealmManager.shared.deleteObject(with: id, type: type) { [weak self] (result) in
            
            switch result{
                case .success(let success):
                    self?.presenter?.success(with: success)
                    
                case .failure(let error):
                    self?.presenter?.error(with: (error as! RealmError).errorMessage)
            }
        }
    }

    func isExistInLovedList(id: String) {
        
        RealmManager.shared.checkIfExist(with: id, type: LovedPodcastModel.self) { (exist) in
            self.presenter?.existedInLovedList(existed: exist)
        }

    }

}
