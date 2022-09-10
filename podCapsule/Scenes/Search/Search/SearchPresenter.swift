//
//  SearchPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/10/22.
//

import Foundation

class SearchPresenter: SearchViewPresenter {
   
    weak var view: SearchView?
    var interactor: SearchInteractorInput?
    var router: SearchViewRouter?
    
    required init(view: SearchView, interactor: SearchInteractorInput, router: SearchViewRouter) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    func searchPressed() {
        router?.moveToSearchController()
    }
    
}


extension SearchPresenter: SearchInteractorOutput{
    
}
