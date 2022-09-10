//
//  IntersetsVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/9/22.
//

import UIKit

class CategoriesInterestVC: UIViewController {

    @IBOutlet weak var IntersetsTableView: UITableView!
    var presenter: CategoriesInterestViewPresenter?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDoneButton()
        presenter?.viewDidLoad()
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.navigationBar.isHidden = true
    }

    private func configureTableView(){
        IntersetsTableView.delegate = self
        IntersetsTableView.dataSource = self
        IntersetsTableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }

    
    
    private func configureDoneButton(){
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        navigationItem.setRightBarButton(doneButton, animated: true)
    }
    
    @objc private func doneButtonPressed(){
        presenter?.donePressed()
    }
}
