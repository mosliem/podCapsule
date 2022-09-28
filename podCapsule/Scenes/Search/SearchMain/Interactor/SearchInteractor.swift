//
//  SearchInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation


class SearchInteractor: SearchInteractorInput{
    
    weak var presenter: SearchInteractorOutput?
    
    func fetchSuggestedPodcast(pageNumber: Int){
        
        let endpoint = SearchRequest.fetchSuggestedPodcast(pageNumber: pageNumber)
        
        NetworkManger.shared.callRequest(objectType: PopularPodcasts.self, endpoint: endpoint) {[weak self] (result) in
            
            switch result {
            
            case .success(let result):
                self?.presenter?.success(with: result)
                
            case .failure(let error):
                self?.presenter?.failed(with: error)
            }
        }
        
    }
     
}
