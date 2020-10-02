//
//  TabbarController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit

class TabbarController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var infoButton: UIButton!
    
    var HomeViewController: UIViewController!
    var PlayViewController : UIViewController!
    var LeaderboardViewController : UIViewController!
    var StoryViewController : UIViewController!
    var ProfileViewController : UIViewController!
    var RulesViewController : UIViewController!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    var share : Bool = false
    var shareImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeViewController = storyBoard.instantiateViewController(identifier: "HomeViewController")
        setupButtons()
        instantiateViews()
        setupHeader()
        setupView(HomeViewController)
    }
    
    @IBAction func tabSelected(_ sender: UIButton) {
        if share {
            guard let image = self.shareImage else { return }
            let imageToShare = [image]
            let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
            self.present(activityViewController, animated: true, completion: nil)
            header.isHidden = false
        } else {
            header.isHidden = (sender.tag == 4)
            let previousIndex = selectedIndex
            selectedIndex = sender.tag
            buttons[previousIndex].isSelected = false
            UIView.animate(withDuration: 0.4) {
                self.buttons[previousIndex].bottomShadow(8)
                self.buttons[self.selectedIndex].bottomShadow(2)
            }
            
            let previousVC = viewControllers[previousIndex]
            previousVC.willMove(toParent: nil)
            previousVC.view.removeFromSuperview()
            previousVC.removeFromParent()
            sender.isSelected = true
            let vc = viewControllers[selectedIndex]
            checkForShare(vc)
            addChild(vc)
            setupView(vc)
            vc.didMove(toParent: self)
        }
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        header.isHidden = true
    }
    
    func checkForShare(_ vc : UIViewController){
        if let viewController = vc as? PlayViewController{
            viewController.delegate = self
        }
    }
    
    func setupHeader(){
        header.roundCorners(corners: [.topLeft,.topRight])
        header.layer.borderWidth = 3
        header.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        header.isHidden = true
    }
    
    func instantiateViews(){
        PlayViewController = storyBoard.instantiateViewController(identifier: "PlayViewController")
        LeaderboardViewController = storyBoard.instantiateViewController(identifier: "LeaderboardViewController")
        StoryViewController = storyBoard.instantiateViewController(identifier: "StoryViewController")
        ProfileViewController = storyBoard.instantiateViewController(identifier: "ProfileViewController")
        
        RulesViewController = storyBoard.instantiateViewController(identifier: "RulesViewController")
        
        viewControllers = [PlayViewController,LeaderboardViewController,StoryViewController,ProfileViewController,RulesViewController]
    }
    
    
    func setupView(_ viewController : UIViewController){
        viewController.view.frame = containerView.bounds
        viewController.view.layer.cornerRadius = 4
        viewController.view.layer.borderWidth = 3
        viewController.view.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        containerView.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
    
    func setupButtons(){
        for button in buttons{
            button.bottomShadow(8)
        }
    }
}


extension TabbarController: ShareDelegate{
    func setShare(bool: Bool, image: UIImage?) {
        print("BOOL:",bool)
        let imageName = bool ? "share" : "Hint"
        let image = UIImage(named: imageName)
        infoButton.setBackgroundImage(image, for: .normal)
        self.shareImage = image
        self.share = bool
    }
}
