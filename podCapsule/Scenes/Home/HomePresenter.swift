//
//  HomePresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import Foundation

class HomePresenter: HomeViewPresenter{

 
    var view: HomeView?

    
    required init(view: HomeView?) {
        self.view = view
    }

    
    func viewDidAppear() {
        
    }
    
    
    func numberOfSections() -> Int {
        return 10
    }
    
    func itemsForSection(for section: Int) -> Int {
        return 10
    }
    
    func titleForSection(for section: Int, header: HomeCollectionReusableViewInput){
        let title = HomeSectionHeader.titleForIndex(index: section)  ?? ""
        header.dispalySectionTitle(text: title)
    }
    
}
 
