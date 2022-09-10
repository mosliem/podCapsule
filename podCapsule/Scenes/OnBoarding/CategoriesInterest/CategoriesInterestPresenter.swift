//
//  IntersetsPresenter.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/9/22.
//

import Foundation


protocol CategoriesSelectionDelegate: class {
    func back(with categories: [String])
}

class CategoriesInterestPresenter: CategoriesInterestViewPresenter {
    
    weak var view: CategoriesInterestView?
    weak var categoryDelegate: CategoriesSelectionDelegate?
    var router: CategoriesInterestViewRouter?
    
    var categories = [String]()
    var isSelectedCategory = [Bool](repeating: false, count: 21)
    
    required  init(view: CategoriesInterestView, router: CategoriesInterestViewRouter){
        self.router = router
        self.view = view
    }
    
    func viewDidLoad(){
        categories = categoryId.map{$0.key}
    }
    
    func categoriesCount() -> Int {
        return categories.count
    }
    
    func configureCell(for cell: CategoryCellView, at indexPath: Int){
        
        let title = categories[indexPath]
        cell.displayCategoryTitle(title: title)
        isSelectedCategory[indexPath] ? cell.setMarked() : cell.setUnmarked()
    
    }
    
    func selectCell(cell: CategoryCellView, at indexPath: Int) {
        
        if isSelectedCategory[indexPath]{
            cell.setUnmarked()
            isSelectedCategory[indexPath] = false
        }
        else{
            cell.setMarked()
            isSelectedCategory[indexPath] = true
        }
        
    }
    
    func donePressed() {
        
        var categoryList = [String]()
        
        for i  in 0 ..< isSelectedCategory.count {
            
            if isSelectedCategory[i]{
                categoryList.append(categories[i])
            }
        }
        categoryDelegate?.back(with: categoryList)
        router?.dismissCategoriesInterset()
    }
}
