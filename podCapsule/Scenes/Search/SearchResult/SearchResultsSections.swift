//
//  SearchResultsSections.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/16/22.
//

import Foundation


enum SearchResultsSections: Int, CaseIterable {
    
    case Podcasts = 0
    case Episodes = 1
    
    var title: String {
        switch self {
        
        case .Podcasts:
            return "Podcasts"
        case .Episodes:
            return "Episodes"
        }
    }
    
    
    static func titleForSection(index: Int) -> String {
        return self.allCases.first{ $0.rawValue == index }!.title
    }
    
    static func typeForSection(index: Int) -> SearchResultsSections{
        return self.allCases.first{$0.rawValue == index}!
    }
}
