//
//  TabbarController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 30/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WatchConnectivity

class TabbarController: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var header: UIView!
    @IBOutlet weak var infoButton: UIButton!
    
    var HomeViewController: HomeViewController!
    var PlayViewController : UIViewController!
    var LeaderboardViewController : UIViewController!
    var StoryViewController : UIViewController!
    var ProfileViewController : UIViewController!
    var RulesViewController : UIViewController!
    var viewControllers: [UIViewController]!
    
    var wcSession : WCSession! = nil
    var selectedIndex: Int = 0
    var share : Bool = false
    var shareImage : UIImage?
    let storyBoard = UIStoryboard(name: "Main", bundle: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        HomeViewController = storyBoard.instantiateViewController(identifier: "HomeViewController")
        self.HomeViewController.delegate = self
        setupButtons()
        instantiateViews()
        setupView(HomeViewController)
        wcSession = WCSession.default
        wcSession.delegate = self
        wcSession.activate()
        if Defaults.isLoggedin(){ tabSelected(buttons[0]) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        header.isHidden = !Defaults.isLoggedin()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupHeader()
    }
    
    @IBAction func tabSelected(_ sender: UIButton) {
        if Defaults.isLoggedin() {
            if share && sender.tag == 4{
                guard let image = self.shareImage else { return }
                let imageToShare = [image]
                let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
                
                if let popoverController = activityViewController.popoverPresentationController {
                    popoverController.sourceRect = CGRect(x: UIScreen.main.bounds.width / 1.5, y: UIScreen.main.bounds.height / 1.75, width: 0, height: 0)
                    popoverController.sourceView = self.view
                    popoverController.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                }
                
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
    }
    
    @IBAction func infoClicked(_ sender: Any) {
        header.isHidden = true
    }
    
    func checkForShare(_ vc : UIViewController){
        if let viewController = vc as? PlayViewController{
            viewController.delegate = self
        }
        if let viewController = vc as? ProfileViewController{
            viewController.delegate = self
        }
    }
    
    func setupHeader(){
        header.roundCorners(corners: [.topLeft,.topRight])
        header.layer.borderWidth = 3
        header.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
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
        let buttonImage = UIImage(named: imageName)
        infoButton.setBackgroundImage(buttonImage, for: .normal)
        self.shareImage = image
        self.share = bool
    }
}

extension TabbarController: LogoutDelegate{
    func logout() {
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        viewDidLoad()
        viewDidLayoutSubviews()
        viewWillAppear(true)
    }
}

extension TabbarController: SigninDelegate, WCSessionDelegate {
    
    
    func didSignin(_ token: String) {
        header.isHidden = false
        tabSelected(buttons[0])
        
        let message = ["token":token]
           
        wcSession.sendMessage(message, replyHandler: nil) { (error) in
               
        print(error.localizedDescription)
               
           }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(activationState)
        print(error)
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("active: ",session)
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("Deactive: ",session)
    }
    
}



