//
//  EpisodeObject.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/7/22.
//

import Foundation

struct EpisodeObject: Codable {
    
    let id: String
    let title: String
    let audio: String
    let description: String
    let image: String
    let audio_length_sec: Int
    let podcast: PodcastObject?
    
}
