//
//  TabBarVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import UIKit

class TabBarVC: UITabBarController, TabBarView {
    
    var presenter: TabBarViewPresenter?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        presenter?.viewWillAppear()
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarView()
    }
 
    
    private func setupTabBarView(){
        
        tabBar.tintColor = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
        let appearnce = UITabBarItem.appearance()
        let attributes = [
            NSAttributedString.Key.font: UIFont(name: "Helvetica Neue Bold", size: 14)!
        ] as [NSAttributedString.Key: Any]
        
        appearnce.setTitleTextAttributes(attributes, for: .normal)
    }
    




}
