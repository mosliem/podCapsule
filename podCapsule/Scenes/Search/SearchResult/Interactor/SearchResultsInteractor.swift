//
//  SearchResultsInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/11/22.
//

import Foundation


class SearchResultsInteractor: SearchResultsInteractorInput{
   
    
    weak var presenter: SearchResultsInteractorOutput?
    
    func search <T: Codable> (for query: String, type: String, sortByDate: Bool, objectType: T.Type) {
        
        let endpoint = SearchResultRequest.searchFor(query: query, type: type, sortByDate: sortByDate)
        
        NetworkManger.shared.callRequest(objectType: objectType, endpoint: endpoint) { [weak self] (result) in

            switch result{

            case .success(let result):
                
                switch SearchQueryType.ObjectForType(type: type){
                
                case .podcast:
                    self?.presenter?.success(with: result as! PodcastSearchResponse)
                
                case .episode:
                    self?.presenter?.success(with: result as! EpisodeSearchResponse)
                }
        
            case .failure(let error):
                self?.presenter?.failed(with: error)
            }
        }
    }
    

    
}
