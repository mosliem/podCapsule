//
//  PodcastObject.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/6/22.
//

import Foundation

struct PodcastObject: Codable {
    
    let id: String
    let title: String
    let publisher: String
    let image: String
    let description: String?
    let total_episodes: Int?
    
}
