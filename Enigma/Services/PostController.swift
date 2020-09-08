//
//  PostController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation

class PostController {
    static let shared: PostController = PostController()
    
    func signup(type: SignupType,body:SignupRequest,completion: @escaping(Bool,SignupResponse?,String) -> ()) {
        WebHelper.sendPOSTRequest(url: type.url, responseType: SignupResponse.self, body: body) { (response, error) in
            if let response = response,let _ = response.key{
                completion(true,response,"success")
            }else{
                completion(false,nil,error?.localizedDescription ?? "Error")
            }
        }
    }
    
}
