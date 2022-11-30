//
//  RecentlyPlayedPodcastModel.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/1/22.
//

import RealmSwift


class RecentlyPlayedPodcastModel: Object{
    
    @Persisted(primaryKey: true) var id: String
    @Persisted var title: String
    @Persisted var publisher: String?
    @Persisted var image: String?
    @Persisted var info: String?
    @Persisted var total_episodes: Int?
    @Persisted var genre_ids: List<Int?>
    

}
