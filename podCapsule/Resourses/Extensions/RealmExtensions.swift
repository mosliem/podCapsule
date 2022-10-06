//
//  RealmExtensions.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/6/22.
//

import RealmSwift

extension List {
    
    // Genertic function to convert Results list to an array of the same Results type
    func toArray<T>(type: T.Type) -> [T] {
        return compactMap {
            $0 as? T
        }
    }
}
