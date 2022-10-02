//
//  RandomEpisodesResponse.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import Foundation

struct RandomEpisodesResponse: Codable {
    
    let id: String
    let title: String
    let audio: String
    let description: String
    let image: String?
    let audio_length_sec: Int
    let podcast: RandomEpisodePodcastResponse?
}
