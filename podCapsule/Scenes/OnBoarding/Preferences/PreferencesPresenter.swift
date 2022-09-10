//
//  PreferencesPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/8/22.
//

import Foundation

class PreferencesPresenter: PreferencesViewPresenter{
    
    var interactor: PreferencesInteractorInput?
    weak var view: PreferencesView?
    var router: PreferencesViewRouter?
    
    var selectedCategories = [String]()
    var selectedCountry: String?
    
    required init(view: PreferencesView, interactor: PreferencesInteractorInput, router: PreferencesViewRouter) {
        
        self.router = router
        self.interactor = interactor
        self.view = view
    }
    
    func selectCountryPressed() {
        router?.viewCountryPickerVC()
    }
    
    func selectedCountry(country: CountryModel) {
        
        selectedCountry = country.countryCode
        
        view?.updateCountryInformationField(
            with: country.countryName,
            countryImage: "CountryPickerController.bundle/"+country.countryCode
        )
        
    }
    
    func selectCategoriesInterest(){
        router?.viewCategoriesInterest()
    }
    
    func continuePressed(){

        guard let country = selectedCountry else{
            view?.showAlert(with: "You must select a country")
            return
        }
        
        guard !selectedCategories.isEmpty else {
            view?.showAlert(with: "You must select at least one category")
            return
        }
        
        interactor?.saveSelectedCountry(country: country, for: "country")
        
        var cateories = [CategoryModel]()
        for category in selectedCategories {
            cateories.append(CategoryModel(name: category, id: categoryId[category]!))
        }
        
        interactor?.saveSelectedCategories(categories: cateories)
    }
    
}


extension PreferencesPresenter: CategoriesSelectionDelegate{
    
    func back(with categories: [String]) {
        self.selectedCategories = categories
        
        if selectedCategories.isEmpty{
            view?.setCategoriesInterestPlaceholder()
        }
        else{
            let categoriesString = categories.map{$0}.joined(separator: " , ")
            view?.setCategoriesInterestSelection(categories:categoriesString)
        }
        view?.updateCategoryFieldsView()
    }
}

extension PreferencesPresenter: PreferencesInteractorOutput{
    
    func addingSucceeded() {
        router?.viewTabBar()
    }
    
    func failedWith(error: Error) {
        print((error as! RealmError).errorMessage)
    }
    
    
}
