//
//  PreferencesInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/8/22.
//

import Foundation

class PreferencesInteractor: PreferencesInteractorInput {

    weak var presenter: PreferencesInteractorOutput?
    
    func saveSelectedCategories(categories: [CategoryModel]) {

        RealmManager.shared.replaceAllObjects(CategoryModel.self, with: categories) { [weak self] (result) in
            
            switch result{
            
            case .success(_):
                self?.presenter?.addingSucceeded()
            case .failure(let error):
                self?.presenter?.failedWith(error: error)
            }
        }
    }

    func saveSelectedCountry(country: String,for key: String){
        UserDefaultManger.shared.addObject(country, key: key)
    }
    
}
