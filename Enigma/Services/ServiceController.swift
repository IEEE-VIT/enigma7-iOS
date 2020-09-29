//
//  ServiceController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

class ServiceController {

static let shared: ServiceController = ServiceController()
    
    
    func getUserDetails(completion : @escaping (UserDetails?)->()){
        WebHelper.sendGETRequest(url: NetworkConstants.Users.userDetailsURL, parameters: [:], responseType: UserDetails.self) { (response, error) in
                completion(response)
        }
    }
    
}
