//
//  PodcastDetailsObject.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/4/22.
//

import Foundation

struct PodcastDetailsObject: Codable {
 
    let description: String?
    let episodes: [EpisodeObject]
    
}
