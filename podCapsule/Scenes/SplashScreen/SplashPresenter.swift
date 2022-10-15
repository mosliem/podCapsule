//
//  SplashPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/15/22.
//

import Foundation


class SplashPresenter: SplashViewPresenter {
    
    weak var view: SplashView?
    var interactor: SplashInteractorInput?
    var router: SplashViewRouter?

    internal var newInstalled: Bool?
    
    required init(view: SplashView?, router: SplashViewRouter?, interactor: SplashInteractorInput?) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        view?.startAnimation()
        interactor?.checkIfNewInstalled()
    }
    
    func finishedAnimation() {
        let newInstalled = self.newInstalled ?? false
        
        if newInstalled {
            router?.moveToPreferencesVC()
        }
        else{
            router?.moveToTabBarView()
        }
    }
}

extension SplashPresenter: SplashInteractorOutput{
    
    func newInstalled(result: Bool) {
        print(result)
        self.newInstalled = result
    }
    
    func error(with: String) {
        print(error)
        self.newInstalled = true
    }
}
