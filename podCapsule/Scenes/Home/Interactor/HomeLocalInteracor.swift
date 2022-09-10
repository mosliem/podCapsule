//
//  HomeLocalInteracor.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

class HomeLocalInteractor: HomeLocalInteractorInput{
    
    weak var presenter: HomeLocalInteractorOutput?
    
    func getCategories() {
      
        RealmManger.shared.retrieveAllObjects(CategoryModel.self) { (result) in
            
            switch result {
            
            case .success(let cateories):
                self.presenter?.success(with: cateories as! [CategoryModel])
                
            case .failure(let error):
                self.presenter?.failed(with: error)
            }
        }
    
    }
    
    
}
