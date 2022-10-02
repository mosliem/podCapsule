//
//  HomePodcastResponse.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import Foundation

struct HomePodcastResponse: Codable {
    let id: String?
    let title: String
    let publisher: String
    let image: String?
}
