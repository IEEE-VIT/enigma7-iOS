//
//  ProfileIntentViewController.swift
//  Enigma-SiriUI
//
//  Created by Aaryan Kothari on 26/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import IntentsUI

// As an example, this extension's Info.plist has been configured to handle interactions for INSendMessageIntent.
// You will want to replace this or add other intents as appropriate.
// The intents whose interactions you wish to handle must be declared in the extension's Info.plist.

// You can test this example integration by saying things to Siri like:
// "Send a message using <myApp>"

class ProfileIntentViewController: UIViewController, INUIHostedViewControlling {
    
    
    @IBOutlet weak var label: UILabel!
    
    
    var profile = User(identifier: "", display: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
        
    // MARK: - INUIHostedViewControlling
    
    // Prepare your view controller for the interaction to handle.
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        guard interaction.intent is ProfileIntent else {
          completion(true, Set(), .zero)
          return
        }
        
        if let response = interaction.intentResponse as? ProfileIntentResponse {
            guard let user = response.userDetails else { return }
            
            self.profile = user
            label.text = user.userName
        }
        completion(true, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        var size = self.extensionContext!.hostedViewMaximumAllowedSize
        size.height /= 2
        return size
    }
    
}
