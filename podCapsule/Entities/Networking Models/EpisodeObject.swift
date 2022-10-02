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
    let image: String?
    let audio_length_sec: Int
    let podcast: PodcastObject?
    
    private enum CodingKeys: String, CodingKey{
        case id,
             title = "title_original",
             audio, image, description = "description_original",
             audio_length_sec,
             podcast
    }
}
