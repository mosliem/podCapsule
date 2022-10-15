//
//  SplashScreenVC.swift
//  podCapsule
//
//  Created by mohamedSliem on 10/15/22.
//

import UIKit
import Lottie

class SplashScreenVC: UIViewController {

    var presenter: SplashViewPresenter?

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var animationContainerView: UIView!
    var logoAnimation: AnimationView?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

}

extension SplashScreenVC: SplashView{
    
    func startAnimation() {
        animateNameLabel()
        animateLogo()
    }
    
    func animateNameLabel(){
        var charIndex = 1
        let text = "PodCapsule"
        
        for letter in text
        {
            Timer.scheduledTimer(withTimeInterval: 0.2 * Double(charIndex), repeats:false) { (timer) in
                self.nameLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
    
    func animateLogo(){
        
        logoAnimation = AnimationView(name: "logo")
        logoAnimation?.frame = CGRect(x: (animationContainerView.frame.width / 2) - 150, y: animationContainerView.frame.height - 250, width: 300, height: 300)
        
        animationContainerView.addSubview(logoAnimation!)
       
        Timer.scheduledTimer(withTimeInterval: 3 , repeats: false) { [weak self](_) in
            self?.logoAnimation?.play()
            self?.logoAnimation?.loopMode = .playOnce
            self?.logoAnimation?.animationSpeed = 0.7
    
        }

        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { [weak self](_) in
            self?.presenter?.finishedAnimation()
        }
    }
    
}
