//
//  SearchRequest.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/15/22.
//

import Foundation

enum SearchRequest: Endpoint{
    
    case fetchSuggestedPodcast(pageNumber: Int)
    
    var URLPath: String {
        return "curated_podcasts"
    }
    
    var parameters: Parameters {
        var parameters: [String: Any]
        
        switch self {
        
        case .fetchSuggestedPodcast( let pageNumber):
            parameters = ["page": pageNumber]
        }
        
        return parameters
    }
    
    var method: HTTPMethod{
        return .GET
    }
    
    
}
