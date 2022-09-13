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
    case fetchBestForCategory(genre_id: Int, pageNum: Int, region: String)
    
    var URLPath: String {
        switch self {
        case .fetchPopularPodcastsList:
            return "curated_podcasts"
            
        case .fetchRandomEpisode:
            return "just_listen"
        case .fetchBestForCategory:
            return "best_podcasts"
        }
    }
    
    var parameters: Parameters {
        
        var parameters = defualtParameters
        switch self {
        
        case .fetchPopularPodcastsList(let pageNumber):
        parameters = ["page": pageNumber]
            
        case .fetchRandomEpisode:
            parameters = [:]
            
        case .fetchBestForCategory(genre_id: let genre_id, pageNum: let pageNum, region: let region):
            parameters = ["page":pageNum, "genre_id": genre_id]
            
        }
        return parameters
    }
    
    
    var method: HTTPMethod{
        switch self {
        case .fetchPopularPodcastsList:
            return .GET
        case .fetchRandomEpisode:
            return .GET
        case .fetchBestForCategory:
            return .GET
        }
    }
}
