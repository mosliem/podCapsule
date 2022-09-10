//
//  UserDefaultManger.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation


class UserDefaultManger {
    
    static let shared = UserDefaultManger()
    private let userDefaults = UserDefaults()
    
    private init(){}
    
    func addObject(_ T: Any, key: String){
         userDefaults.set(T, forKey: key)
    }
    
    func removeObject(key: String){
        userDefaults.removeObject(forKey: key)
    }
    
    func retrieveObject(for key: String) -> Any?{
       return userDefaults.object(forKey: key)
    }
}
