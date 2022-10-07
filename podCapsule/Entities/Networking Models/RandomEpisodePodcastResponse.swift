//
//  PodcastResponse.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/16/22.
//

import Foundation

struct RandomEpisodePodcastResponse: Codable {
    
    let id: String
    let title: String
    let publisher: String
    let image: String?
    let listennotes_url: String?
    
}
