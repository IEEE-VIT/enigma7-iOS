//
//  Instagram Webview.swift
//  Enigma
//
//  Created by Aaryan Kothari on 20/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit
import WebKit


class WebViewController: UIViewController, WKNavigationDelegate {
    var instagramApi: InstagramApi?
    var testUserData: InstagramTestUser?
    var mainVC: HomeViewController?
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        instagramApi?.authorizeApp { (url) in
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url!))
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request
        self.instagramApi?.getTestUserIDAndToken(request: request) { [weak self] (instagramTestUser) in
            self?.testUserData = instagramTestUser
            DispatchQueue.main.async {
                self?.dismissViewController()
            }
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    func dismissViewController() {
        self.dismiss(animated: true) {
            print(self.testUserData)
        }
    }
}

