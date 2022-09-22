//
//  SearchResultRequest.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/15/22.
//

import Foundation

enum SearchQueryType : String, Codable, CaseIterable{
 
    case podcast
    case episode
    
    static func ObjectForType (type: String) -> SearchQueryType {
        return self.allCases.first{$0.rawValue == type}!
    }
}

enum SearchResultRequest: Endpoint {
   
    case searchFor(query: String, type: String, sortByDate: Bool)
    
    var URLPath: String{
        switch self {
        case .searchFor:
            return "search"
        }
    }
    
    var parameters: Parameters {
        
        var parameter: [String : Any]
        
        switch self {
        
        case .searchFor(let query, let type, let sortByDate):
            parameter = ["q": query, "type": type, "sort_by_date": sortByDate, "only_in": "title,description,author,audio"]
        }
        
        return parameter
    }
    
    var method: HTTPMethod{
        
        switch self {
        
        case .searchFor:
            return .GET
        }
    }
}
