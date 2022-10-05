//
//  PodcastDetailsInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import Foundation

class PodcastDetailsInteractor: PodcastDetailsInteractorInput{
 
    var presenter: PodcastDetailsInteractorOutput?

    
    func getPodcastDetails(with id: String, sort: String){

        let endpoint = PodcastDetailsRequest.getPodcastDetails(id: id, sort: sort)
        
        NetworkManger.shared.callRequest(objectType: PodcastDetailsObject.self, endpoint: endpoint) { [weak self](result) in
            
            switch result{
                case .success(let podcastDetails):
                    self?.presenter?.success(with: podcastDetails)
                
                case .failure(let error):
                    self?.presenter?.failed(with: error)
            }
        }
    }
}
