//
//  HomeVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 9/1/22.
//

import UIKit

class HomeVC: UIViewController {
    
    var presenter: HomeViewPresenter?
    
    internal var homeCollectionView: UICollectionView?
    
    internal var homeSectionsLayout = [NSCollectionLayoutSection]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupNavigationBarAppearance()
        presenter?.viewWillAppear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHomeCollectionView()
        presenter?.viewDidLoad()
    }
    
    deinit {
        print("Home Deinit")
    }
    
   private func setupNavigationBarAppearance(){
    
        let color = #colorLiteral(red: 0.1128981188, green: 0.2162761092, blue: 0.2516562045, alpha: 1)
        let appearance = UINavigationBarAppearance()
        let attributes = [NSAttributedString.Key.foregroundColor: color] as [NSAttributedString.Key: Any]
        
        appearance.titleTextAttributes = attributes
        appearance.largeTitleTextAttributes = attributes
        navigationItem.title = "Home"
        navigationController?.navigationBar.standardAppearance = appearance
   }
    
    internal func configureHomeCollectionView(){
        
        homeCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init())
        
        homeCollectionView?.register(UINib(nibName: PodcastCell.identifier, bundle: nil), forCellWithReuseIdentifier: PodcastCell.identifier)
        
        homeCollectionView?.register(UINib(nibName: RecentlyPlayedCell.identifier, bundle: nil), forCellWithReuseIdentifier: RecentlyPlayedCell.identifier)
        
        homeCollectionView?.register(SectionsCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionsCollectionReusableView.identifier)
        
        homeCollectionView?.delegate = self
        homeCollectionView?.dataSource = self
        
        homeCollectionView?.frame = CGRect(x: 10, y: 0, width: view.bounds.width , height: view.bounds.height )
        homeCollectionView?.backgroundColor = .clear
        view.addSubview(homeCollectionView!)
    }
    
    internal  func createLayout() -> UICollectionViewLayout {
        
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex, _) -> NSCollectionLayoutSection? in
            return self?.homeSectionsLayout[sectionIndex]
        }
        return layout
    }
    
}


//Creating Collection Sections
extension HomeVC{
    func createRecentlyPlayedSection() -> NSCollectionLayoutSection {
        
        let sectionHeader = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(60)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
        ]
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.95), heightDimension: .absolute(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 0 , bottom: 4, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item,item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.boundarySupplementaryItems = sectionHeader
        return section
    }
    
    func createPodcastsSection() -> NSCollectionLayoutSection {
        
        let sectionHeader = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(60)),
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top
            )
        ]
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(230), heightDimension: .absolute(240))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 5, bottom: 0, trailing: 5)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(250))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.boundarySupplementaryItems = sectionHeader
        return section
    }
}
