//
//  SettingsVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/8/22.
//

import UIKit
import SKCountryPicker
import RSSelectionMenu


class PreferencesVC: UIViewController {
    
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var countryNameTextField: UITextField!
    @IBOutlet weak var countrySelectionButton: UIButton!
    @IBOutlet weak var intersetsTextView: UITextView!
    @IBOutlet weak var categoriesInterestButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    var presenter: PreferencesViewPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCountryImageView()
        configurecategoriesInterestButton()
        configureInterestTextView()
        configureContinueButton()
    }

    @IBAction func didPressCountrySelectionButton(_ sender: UIButton) {
        presenter?.selectCountryPressed()
    }
    
    @IBAction func didPressIntersetsSelectionButton(_ sender: UIButton) {
        presenter?.selectCategoriesInterest()
    }
    
    private func configureCountryImageView(){
        countryImageView.layer.cornerRadius = 5
        countryImageView.clipsToBounds = true
    }
    
    private func configurecategoriesInterestButton(){
        categoriesInterestButton.layer.cornerRadius = 10
        categoriesInterestButton.clipsToBounds = true
        
        categoriesInterestButton.roundButtonWithShadows(cornerRadius: 10)
    }
  
    private func configureInterestTextView(){
        intersetsTextView.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 10)
    }
    
    private func configureContinueButton(){
        continueButton.roundButtonWithShadows(cornerRadius: 10, shadowRadius: 5, shadowOpicity: 0.3, shadowOffset: CGSize(width: 0, height: 2.5), shadowColor: .lightGray)
    }
    
    
    @IBAction func continueButtonPressed(_ sender: UIButton) {
        presenter?.continuePressed()
    }
    
}
