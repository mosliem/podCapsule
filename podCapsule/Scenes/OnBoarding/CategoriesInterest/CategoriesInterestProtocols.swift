//
//  IntersetsProtocols.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/9/22.
//

import UIKit


protocol CategoriesInterestView: class {
    
    var presenter: CategoriesInterestViewPresenter? { get set }
}

protocol CategoryCellView: class {
    
    func displayCategoryTitle(title: String)
    func setMarked()
    func setUnmarked()
}

protocol CategoriesInterestViewPresenter: class {
    
    var view: CategoriesInterestView? { get set }
    var router: CategoriesInterestViewRouter? { get set }
    var categoryDelegate: CategoriesSelectionDelegate? { get set }
    
    init(view: CategoriesInterestView, router: CategoriesInterestViewRouter)
    
    func viewDidLoad()
    func categoriesCount() -> Int
    func configureCell(for cell: CategoryCellView, at indexPath: Int)
    func selectCell(cell: CategoryCellView, at indexPath: Int)
    func donePressed()

    
}

protocol CategoriesInterestViewRouter: class {
    
    var view: UIViewController? { get set }
    func dismissCategoriesInterset()
}


