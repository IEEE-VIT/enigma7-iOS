//
//  Constants.swift
//  Enigma
//
//  Created by Aaryan Kothari on 29/08/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import UIKit


let storyBoard = UIStoryboard(name: "Main", bundle: nil)

let maxXp : Double = 300

extension UIColor {
    static let dark = #colorLiteral(red: 0.03137254902, green: 0.05490196078, blue: 0.03137254902, alpha: 1)
    static let primary = #colorLiteral(red: 0.09411764706, green: 0.1843137255, blue: 0.1411764706, alpha: 1)
    static let secondary = #colorLiteral(red: 0.07843137255, green: 0.368627451, blue: 0.07843137255, alpha: 1)
    static let tertiary = #colorLiteral(red: 0.1137254902, green: 0.7215686275, blue: 0.09411764706, alpha: 1)
    static let quaternary = #colorLiteral(red: 0.1490196078, green: 0.8745098039, blue: 0.1294117647, alpha: 1)
    static let light = #colorLiteral(red: 0.9333333333, green: 0.9568627451, blue: 0.9098039216, alpha: 1)
}

enum httpMethod: String {
    case PUT
    case POST
    case GET
    case PATCH
}

class Keys {
    static let login = "EnigmaLogin"
    static let token = "EnigmaToken"
    static let user = "EnigmaUser"
    static let leaderboard = "EnigmaLeaderboard"
    static let question = "EnigmaQuestion"
    static let hint = "EnigmaHint"
    static let xp = "Enigmaxp"
}

func decode<T: Decodable>(data: Data) -> T? {
    let decoder = JSONDecoder()
    do {
        let body = try decoder.decode(T.self, from: data)
        return body
    } catch {
        return nil
    }
}

func DebugRequest(_ url : String,status : URLResponse?,request : Data, response : Data){
    let req = try? JSONSerialization.jsonObject(with: request)
    let res = try? JSONSerialization.jsonObject(with: response)
    let code = status as? HTTPURLResponse
    print("=================================================")
    print("URL: ",url)
    print("\n")
    print("status code:",code?.statusCode ?? 0)
    print("\n")
    print("================      REQUEST BODY      ===============")
    print("\n")
    print(req ?? (Any).self)
    print("\n")
    print("================      RESPONSE BODY     ===============")
    print("\n")
    print(res ?? (Any).self)
    print("\n")
    print("=================================================")
}
