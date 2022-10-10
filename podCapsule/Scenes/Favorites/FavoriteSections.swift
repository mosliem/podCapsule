//
//  FavoriteSections.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/10/22.
//

import Foundation

enum FavoriteSections: String, CaseIterable{
    case Podcasts
    case Episodes
}

struct FavoriteSectionsHandler{
    
    var sections = [FavoriteSections]()
    
    init() {
        sections = []
    }
    mutating func append(section: String){
        
        guard let sectionName = (FavoriteSections.allCases.first{$0.rawValue == section}) else{
            return
        }
        
        sections.append(sectionName)
    }
    
}
