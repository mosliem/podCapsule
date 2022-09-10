//
//  CountryModel.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/8/22.
//

import SKCountryPicker


struct CountryModel {
    
    var countryName: String
    var countryCode: String
    
    init(country: Country) {
        countryName = country.countryName
        countryCode = country.countryCode
    }
}
