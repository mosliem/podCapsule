//
//  SplashInteractor.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/15/22.
//

import Foundation

class SplashInteractor: SplashInteractorInput {
    weak var presenter: SplashInteractorOutput?
    
    func checkIfNewInstalled() {
        
        guard let isNewInstalled = UserDefaultManger.shared.retrieveObject(for: "isNewInstalled") as? Bool else {
            UserDefaultManger.shared.addObject(true, key: "isNewInstalled")
            presenter?.newInstalled(result: true)
            return
        }
        presenter?.newInstalled(result: !isNewInstalled)
    }
    
    
}
