//
//  LovedEpisodeModel.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/1/22.
//

import RealmSwift

class LovedEpisode: Object{
 
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var audioLink: String?
    @Persisted var image: String?
    @Persisted var audio_length_sec: Int
    
}
