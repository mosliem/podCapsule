//
//  PodcastObject.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/6/22.
//

import Foundation

struct PodcastObject: Codable {
    
    let id: String?
    let title: String
    let publisher: String
    let image: String?
    let description: String?
    let total_episodes: Int?
    let genre_ids: [Int]?

    
    private enum CodingKeys: String, CodingKey{
        case id, title = "title_original", publisher = "publisher_original", image, description = "description_original", total_episodes, genre_ids
    }
}
