//
//  SplashProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/15/22.
//

import Foundation

protocol SplashView: class {
    
    var presenter: SplashViewPresenter? { get set }
    func startAnimation()
}

protocol SplashViewPresenter: class {
    
    var view: SplashView? { get set }
    var router: SplashViewRouter? { get set }
    init(view: SplashView?, router: SplashViewRouter?, interactor: SplashInteractorInput?) 
    func viewDidLoad()
    func finishedAnimation()
}


protocol SplashViewRouter: class {
    func moveToPreferencesVC()
    func moveToTabBarView()
}

protocol SplashInteractorInput: class {
    var presenter: SplashInteractorOutput? { get set }
    func checkIfNewInstalled()
}

protocol SplashInteractorOutput: class {
    var interactor: SplashInteractorInput? { get set }
    func newInstalled(result: Bool)
    func error(with: String)
}
