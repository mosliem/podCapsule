//
//  PreferencesDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/8/22.
//

import UIKit
import SKCountryPicker

extension PreferencesVC: PreferencesView{
    
    func showAlert(with errorMessage: String) {
        self.showAlertWithOk(alertTitle: "Error", message: errorMessage, actionTitle: "OK")
    }
    
    
    func setCategoriesInterestPlaceholder() {
        intersetsTextView.text = "Tap here to select your interests"
        intersetsTextView.font?.withSize(15)
        intersetsTextView.textColor = .lightGray
        intersetsTextView.sizeToFit()
    }
    
    func setCategoriesInterestSelection(categories: String) {
        
        intersetsTextView.text = categories
        intersetsTextView.textColor = #colorLiteral(red: 0.0383454673, green: 0.1741192639, blue: 0.2161790133, alpha: 1)
        intersetsTextView.font?.withSize(19)
        intersetsTextView.sizeToFit()
        
    }
    
    func updateCountryInformationField(with countryName: String, countryImage: String) {
        
        let bundle = Bundle(for: CountryPickerView.self)
        countryImageView.contentMode = .scaleAspectFill
        countryNameTextField.text = countryName
        countryImageView.image = UIImage(named: countryImage, in: bundle, compatibleWith: nil)
        
    }
    
    func updateCategoryFieldsView(){
        let height = categoriesInterestButton.heightAnchor.constraint(greaterThanOrEqualToConstant: 55)
        NSLayoutConstraint.activate([height])
        height.constant = intersetsTextView.bounds.size.height
    }
    
}

extension PreferencesVC: CountryPickerDelegate {
    
    func didSelectCountry(_ country: Country) {
        presenter?.selectedCountry(country: CountryModel(country: country))
    }

}

