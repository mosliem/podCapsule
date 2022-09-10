//
//  HomeRequest.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/3/22.
//

import Foundation

enum HomeRequest: Endpoint{
    
    case fetchPopularPodcastsList(pageNumber: Int)
    case fetchRandomEpisode
    
    var URLPath: String {
        switch self {
        case .fetchPopularPodcastsList:
            return "curated_podcasts"
            
        case .fetchRandomEpisode:
            return "just_listen"
        }
    }
    
    var parameters: Parameters {
        
        var parameters = defualtParameters
        switch self {
        case .fetchPopularPodcastsList:
            parameters = ["page":"1"]
            
        case .fetchRandomEpisode:
            parameters = [:]
        }
        return parameters
    }
    
    
    var method: HTTPMethod{
        switch self {
        case .fetchPopularPodcastsList:
            return .GET
        case .fetchRandomEpisode:
            return .GET
        }
    }
}
