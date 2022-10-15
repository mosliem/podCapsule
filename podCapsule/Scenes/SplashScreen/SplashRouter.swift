//
//  SplashRouter.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/15/22.
//

import UIKit

class SplashRouter {
    
    unowned var splashVC: UIViewController?
    
    static func create() -> UIViewController{
        
        let view = SplashScreenVC()
        let router = SplashRouter()
        let interactor = SplashInteractor()
        
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        
        view.presenter = presenter
        router.splashVC = view
        interactor.presenter = presenter
        
        return view
    }
}

extension SplashRouter: SplashViewRouter{
    func moveToPreferencesVC() {
        let vc = PreferencesRouter.create()
        splashVC?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToTabBarView() {
        let vc = TabBarRouter.create()
        UIApplication.shared.windows.first?.rootViewController = vc
        
    }
}
