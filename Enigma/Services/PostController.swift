//
//  PostController.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import GoogleSignIn

class PostController {
    static let shared: PostController = PostController()
    
    func signup(type: SignupType,body:SignUpModel.Request,completion: @escaping(Bool,SignUpModel.Response?) -> ()) {
        WebHelper.sendPOSTRequest(url: type.url, responseType: SignUpModel.Response.self, body: body) { (response, error) in
            if let response = response,let key = response.key{
                UserDefaults.standard.set(true, forKey: Keys.login)
                UserDefaults.standard.set("Token " + key, forKey: Keys.token)
                completion(true,response)
            }else{
                completion(false,nil)
            }
        }
    }
    
    func editUserName(_ body: EditUsernameRequest,completion: @escaping(Bool,EditUsernameResponse?) -> ()) {
        WebHelper.sendPOSTRequest(url: NetworkConstants.Users.editUsernameURL, responseType: EditUsernameResponse.self, body: body, header: true, httpMethod: .PATCH) { (response, statusCode) in
            let success = (200..<300) ~= statusCode
            completion(success,response)
        }
    }
    
    func answerQuestion(_ body: AnswerRequest,closePowerupUsed: Bool,completion: @escaping(Bool,Bool,String)->()){
        let url = closePowerupUsed ? NetworkConstants.Game.closeAnswerPowerupURL : NetworkConstants.Game.answerURL
        WebHelper.sendPOSTRequest(url: url, responseType: AnswerResponse.self, body: body,header: true) { (response, statusCode) in
            if let xp = response?.xp { UserDefaults.standard.set(xp, forKey: Keys.xp) }
            completion(response?.answer ?? false,response?.close_answer ?? false,response?.detail ?? "Uh oh 😕")
        }
    }
    
    func skipQuestion(completion: @escaping(Bool, AnswerResponse?)->()){
        let body = AnswerRequest(answer: "")
        WebHelper.sendPOSTRequest(url: NetworkConstants.Game.skipPowerupURL, responseType: AnswerResponse.self, body: body,header: true,noBody: true) { (response, statusCode) in
            let success = (200..<300) ~= statusCode
            if let xp = response?.xp { UserDefaults.standard.set(xp, forKey: Keys.xp) }
            completion(success,response)
        }
    }
    
    func logout(){
        let body = AnswerRequest(answer: "")
        WebHelper.sendPOSTRequest(url: NetworkConstants.Users.logoutURL, responseType: sample.self, body: body,header: true,noBody: true) { (_, _) in }
        GIDSignIn.sharedInstance()?.signOut()
        UserDefaults.standard.set(false, forKey: Keys.login)
        UserDefaults.standard.set(nil, forKey: Keys.token)
    }
    
}
