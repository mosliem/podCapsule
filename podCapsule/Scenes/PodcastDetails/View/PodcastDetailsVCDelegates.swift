//
//  PodcastDetailsVCDelegates.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/2/22.
//

import UIKit
import SDWebImage


extension PodcastDetailsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
}

extension PodcastDetailsVC: PodcastDetailsView {
 
    func showLoader() {
        self.showIndicator()
    }
    
    func hideLoader() {
        self.hideIndicator()
    }
    
    func reloadEpisodesTableView() {
        
        DispatchQueue.main.async {
            self.episodesTableView.reloadData()
        }
    }
    
    func updateOutletHeight(outlet: UIView){
        let oldheight = outlet.frame.height
        outlet.sizeToFit()
        print(oldheight)
        topViewHeightConstraint.constant = topViewHeightConstraint.constant - abs(outlet.frame.height - oldheight)
        topView.layoutIfNeeded()
        print(topView.frame.height,"top")
    }
    
    func updateScrollViewHeight() {
        
        let newSize = topView.frame.height
        let window = UIApplication.shared.windows.first
        let viewHeight = view.frame.height - ((window?.safeAreaInsets.top)! + (window?.safeAreaInsets.bottom)!)

    
        if newSize > viewHeight {
            let addtionalHeight = newSize - viewHeight
            scrollViewHeightConstraint.constant =  addtionalHeight + (viewHeight * 2)
        }
        else{
            let removedHeight = viewHeight - topView.frame.height
            scrollViewHeightConstraint.constant = (viewHeight * 2) - removedHeight - 25
        }
        
        scrollView.layoutIfNeeded()
    }
    
    func displayPodcastPoster(with url: URL?) {
        podcastPosterImageView.sd_setImage(with: url)
    }
    
    func displayPodcastTitle(title: String) {
        podcastTitleLabel.text = title
        updateOutletHeight(outlet: podcastTitleLabel)
    }
    
    func displayPodcastPublisher(publisher: String) {
        publisherNameLabel.text = publisher
        updateOutletHeight(outlet: publisherNameLabel)
    }
    
    func displayPodcastDescription(description: String) {
        descriptionTextView.text = description
        updateOutletHeight(outlet: descriptionTextView)
    }
    
    func displayEpisodeNumber(number: String) {
        episodesNumberLabel.text = number
    }
    
    func showErrorAlert(title: String, message: String, actionTitle: String, actionHandler: @escaping ((UIAlertAction)?) -> ()) {
        self.showAlertWithOk(alertTitle: title, message: message, actionTitle: actionTitle, actionHandler: actionHandler)
    }
    
}
