//
//  PodcastDetailsRequest.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/4/22.
//

import Foundation


enum PodcastDetailsRequest: Endpoint {
    
    case getPodcastDetails(id: String, sort: String)
    
    
    var URLPath: String{
        switch self {
        
        case .getPodcastDetails(id: let id, sort: _):
            return "podcasts/\(id)"
        }
    }
    
    var parameters: Parameters{

        let parameters: [String: Any]

        switch self {
        case .getPodcastDetails(id: _, sort: let sort):
            parameters = ["sort": sort]
        }

        return parameters
    }
    
    var method: HTTPMethod{
        return .GET
    }

}
