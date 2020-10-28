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
                Defaults.login(key)
                completion(true,response)
            } else {
                completion(false,nil)
            }
        }
    }
    
    func editUserName(_ body: EditUsernameModel.Request,completion: @escaping(Bool,EditUsernameModel.Response?) -> ()) {
        WebHelper.sendPOSTRequest(url: NetworkConstants.Users.editUsernameURL, responseType: EditUsernameModel.Response.self, body: body, header: true, httpMethod: .PATCH) { (response, statusCode) in
            let success = (200..<300) ~= statusCode
            completion(success,response)
        }
    }
    
    func answerQuestion(_ body: AnswerModel.Request,closePowerupUsed: Bool,completion: @escaping(Bool,Bool,String)->()){
        let url = closePowerupUsed ? NetworkConstants.Game.closeAnswerPowerupURL : NetworkConstants.Game.answerURL
        WebHelper.sendPOSTRequest(url: url, responseType: AnswerModel.Response.self, body: body,header: true) { (response, statusCode) in
            if let xp = response?.xp { UserDefaults.standard.set(xp, forKey: Keys.xp) }
            completion(response?.answer ?? false,response?.close_answer ?? false,response?.detail ?? "Uh oh 😕")
        }
    }
    
    func skipQuestion(completion: @escaping(Bool, AnswerModel.Response?)->()){
        let body = AnswerModel.Request(answer: "")
        WebHelper.sendPOSTRequest(url: NetworkConstants.Game.skipPowerupURL, responseType: AnswerModel.Response.self, body: body,header: true,noBody: true) { (response, statusCode) in
            let success = (200..<300) ~= statusCode
            if let xp = response?.xp { UserDefaults.standard.set(xp, forKey: Keys.xp) }
            completion(success,response)
        }
    }
    
    func logout(){
        let body = AnswerModel.Request(answer: "")
        WebHelper.sendPOSTRequest(url: NetworkConstants.Users.logoutURL, responseType: sample.self, body: body,header: true,noBody: true) { (_, _) in }
        GIDSignIn.sharedInstance()?.signOut()
        Defaults.emptyAll()
    }
}
