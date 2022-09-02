//
//  HomeSectionsModel.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import Foundation

enum HomeSectionHeader: Int, CaseIterable {
    case RecentlyPlayed = 0
    case PopularPodcasts = 1
    case BestPodcasts = 2
    case InterestedTopics = 3
    
    var title: String {
        
        switch self {
        case .RecentlyPlayed:
            return "Recently Played"
        case .PopularPodcasts:
            return "Popular Podcasts"
        case .BestPodcasts:
            return "Best Podcasts"
        case .InterestedTopics:
            return "Interested Topics"
        }
    }
    
    static func titleForIndex(index: Int) -> String? {
        return self.allCases.first{$0.rawValue == index}?.title
    }
}
