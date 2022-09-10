//
//  CategoriesInterestRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/9/22.
//

import UIKit

class CategoriesInterestRouter {
    
   internal var view: UIViewController?
   
    static func create() -> UIViewController{
        
        let view = CategoriesInterestVC()
        let router = CategoriesInterestRouter()
        let presenter = CategoriesInterestPresenter(view: view, router: router)
       
        view.presenter = presenter
        router.view = view
        view.navigationController?.navigationBar.isHidden = false
        return view
    }

}

extension CategoriesInterestRouter: CategoriesInterestViewRouter{
   
    
    func dismissCategoriesInterset() {
        view?.navigationController?.popViewController(animated: true)
    }
    
    
}
