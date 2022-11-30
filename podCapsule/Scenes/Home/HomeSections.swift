//
//  HomeSectionsModel.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import Foundation

enum HomeSections: Int, CaseIterable {
    
    case RecentlyPlayed = 0
    case PopularPodcasts = 1
    case JustListen = 2
    
    var title: String {
        
        switch self {
        case .RecentlyPlayed:
            return "Recently Played"
        case .PopularPodcasts:
            return "Popular Podcasts"
        case .JustListen:
            return "Just Listen"
            
        }
    }
    
    static func titleForIndex(index: Int) -> String? {
        return self.allCases.first{$0.rawValue == index}?.title
    }
}
