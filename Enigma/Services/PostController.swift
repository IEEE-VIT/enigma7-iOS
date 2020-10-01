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
            if let response = response,let key = response.key{
                UserDefaults.standard.set("Token " + key, forKey: Keys.token)
                completion(true,response,"success")
            }else{
                completion(false,nil,error?.localizedDescription ?? "Error")
            }
        }
    }
    
    func editUserName(_ body: EditUsernameRequest,completion: @escaping(Bool,String) -> ()) {
        WebHelper.sendPOSTRequest(url: NetworkConstants.Users.editUsernameURL, responseType: EditUsernameResponse.self, body: body, header: true, httpMethod: .PATCH) { (response, error) in
            if let _ = response?.username{
                completion(true,"success")
            }else{
                completion(false,response?.error ?? error.debugDescription)
            }
        }
    }
    
    func answerQuestion(_ body: AnswerRequest,completion: @escaping(Bool,String)->()){
        
    }

}
