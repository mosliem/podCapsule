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
        return "podcasts/"
    }
    
    var parameters: Parameters{
        
        var parameters = defualtParameters
        
        switch self {
        case.getPodcastDetails(id: let id, sort: let sort):
            parameters = ["id": id,"sort": sort]
        }
        
        return parameters
    }
    
    var method: HTTPMethod{
        return .GET
    }
    
}
