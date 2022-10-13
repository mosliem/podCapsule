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
    
    private var sections = [FavoriteSections]()
    
    init() {
        sections = []
    }
    
    mutating func removeAllSections(){
        sections.removeAll()
    }
    
    func typeForIndex(index: Int) -> FavoriteSections{
        return sections[index]
    }
    
    func sectionsCount() -> Int{
        return sections.count
    }
    
    func getSections() -> [FavoriteSections]{
       return sections
    }
    
    mutating func append(section: String){
        
        guard let sectionName = (FavoriteSections.allCases.first{$0.rawValue == section}) else{
            return
        }
        
        if !sections.contains(sectionName){
            sections.append(sectionName)
        }
        
    }
    
    
}
