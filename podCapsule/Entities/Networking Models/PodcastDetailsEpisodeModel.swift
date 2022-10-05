//
//  PodcastDetailsEpisodeModel.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/5/22.
//

import Foundation

struct PodcastDetailsEpisodeModel: Codable {
    let id: String
    let title: String
    let audio: String
    let description: String
    let image: String?
    let audio_length_sec: Int
    let publishDate: Int?
}
