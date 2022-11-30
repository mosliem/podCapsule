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
      
        RealmManager.shared.retrieveAllObjects(CategoryModel.self) { [weak self](result) in
            
            switch result {
            
            case .success(let cateories):
                self?.presenter?.success(with: cateories as! [CategoryModel])
                
            case .failure:
                break
            }
        }
    
    }
    
    
    func getRegion() {
        let country = UserDefaultManger.shared.retrieveObject(for: "country") as! String
        presenter?.success(with: country)
    }
    
    func getRecentlyPlayed(){
      
        RealmManager.shared.retrieveAllObjects(RecentlyPlayedEpisodeModel.self) {[weak self] (result) in
            
            switch result {
                  
            case .success(let episodes):
                self?.presenter?.success(with: episodes as! [RecentlyPlayedEpisodeModel])
            case .failure(let error):
                self?.presenter?.failed(with: (error as! RealmError).errorMessage)
            }
        }
    }
}
