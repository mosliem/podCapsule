//
//  PodcastDetailsVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import UIKit

class PodcastDetailsVC: UIViewController {
    
    var presenter: PodcastDetailsViewPresenter?
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var podcastTitleLabel: UILabel!
    
    @IBOutlet weak var podcastPosterShadowView: UIView!
    @IBOutlet weak var podcastPosterImageView: UIImageView!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var episodesNumberLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var episodesTableView: UITableView!
    
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var scrollViewHeightConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let color = UIColor.clear
        let appearnce = UINavigationBarAppearance()
        
        appearnce.backgroundColor = color
        navigationController?.navigationBar.standardAppearance = appearnce
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderView()
        presenter?.viewDidLoad()
    }
    
    private func renderView(){
        configurePosterShadow()
        roundPodcastPoster()
        configureTopView()
    }
    
    
    private func configureTableView(){
        
        episodesTableView.delegate = self
        episodesTableView.dataSource = self
        
        
    }
    
    private func roundPodcastPoster(){
        podcastPosterImageView.clipsToBounds = true
        podcastPosterImageView.layer.cornerRadius = 20
    }
    
    private func configurePosterShadow(){
        podcastPosterShadowView.layer.cornerRadius = 20
        podcastPosterShadowView.layer.shadowColor = UIColor.lightGray.cgColor
        podcastPosterShadowView.layer.shadowOffset = CGSize(width: 0, height: 5)
        podcastPosterShadowView.layer.shadowRadius = 10
        podcastPosterShadowView.layer.shadowOpacity = 0.3
    }
    
    private func configureTopView(){
        
        topView.layer.cornerRadius = 20
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        topView.layer.shadowColor = UIColor.lightGray.cgColor
        topView.layer.shadowRadius = 15
        topView.layer.shadowOffset = CGSize(width: 0, height: 10)
        topView.layer.shadowOpacity = 0.4
        
    }
}
