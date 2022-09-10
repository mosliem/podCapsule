//
//  CategoryObject.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import RealmSwift

class CategoryModel: Object {
    
    @Persisted var categoryName: String = ""
    @Persisted var categoryId: Int = 0
    
    
    convenience init(name: String, id: Int){
        self.init()
        self.categoryName = name
        self.categoryId = id
    }
}
