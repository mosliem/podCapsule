//
//  BestPodcastsModel.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/12/22.
//

import Foundation

struct BestPodcastsObject: Codable {
    let id: Int?
    let name: String
    let podcasts: [HomePodcastResponse]
}
