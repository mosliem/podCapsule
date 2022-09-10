//
//  PreferencesProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/8/22.
//

import UIKit

protocol PreferencesView: class {
    
    var presenter: PreferencesViewPresenter? { get set }
    
    func updateCountryInformationField(with countryName: String, countryImage: String)
    func setCategoriesInterestPlaceholder()
    func setCategoriesInterestSelection(categories: String)
    func updateCategoryFieldsView()
    func showAlert(with errorMessage: String)
}


protocol PreferencesViewPresenter: class {
    
    var view: PreferencesView? { get set }
    var router: PreferencesViewRouter? { get set }
    
    init(view: PreferencesView, interactor: PreferencesInteractorInput, router: PreferencesViewRouter)
    
    func selectCountryPressed()
    func selectedCountry(country: CountryModel)
    func selectCategoriesInterest()
    func continuePressed()

}

protocol PreferencesViewRouter: class {
    
    var view: UIViewController? { get set }
    
    func viewCountryPickerVC()
    func viewCategoriesInterest()
    func viewTabBar()
    
}


protocol PreferencesInteractorInput: class {
    
    var presenter: PreferencesInteractorOutput? { get set }

    func saveSelectedCategories(categories: [CategoryModel])
    func saveSelectedCountry(country: String,for key: String)
}


protocol PreferencesInteractorOutput: class {
    
    var interactor: PreferencesInteractorInput? { get set }
    
    func addingSucceeded()
    func failedWith(error: Error)
}
