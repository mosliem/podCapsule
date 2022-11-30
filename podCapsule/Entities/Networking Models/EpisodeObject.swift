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
    let publishDate: Int?

    init(id: String, title: String, audio: String, description: String?, image: String?, audio_length: Int, podcast: PodcastObject? = nil){
        self.id = id
        self.title = title
        self.audio = audio
        self.audio_length_sec = audio_length
        self.image = image
        self.podcast = podcast
        self.description = description ?? ""
        self.publishDate = nil
    }
    
    private enum CodingKeys: String, CodingKey{
        case id,
             title = "title_original",
             audio, image, description = "description_original",
             audio_length_sec,
             podcast,
             publishDate = "pub_date_ms"
    }
}
