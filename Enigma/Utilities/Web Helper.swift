//
//  Web Helper.swift
//  Enigma
//
//  Created by Aaryan Kothari on 08/09/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import UIKit

class WebHelper {
        
    class func sendGETRequest<ResponseType: Decodable>(url: String,parameters : [String:String],responseType: ResponseType.Type,key : String? = nil,isWidget:Bool = false, completion: @escaping (ResponseType?,Int) -> Void) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        if let requestURL = components.url {
            var request = URLRequest(url: requestURL)

            let defaults = UserDefaults(suiteName: "group.widget.ak")
            let token = defaults?.string(forKey: "Token")
            defaults?.synchronize()
            
            var key = isWidget ? token : Defaults.token()
            
            #if os(watchOS)
                key = UserDefaults.standard.value(forKey: "token") as? String //TODO
                print("WATCH:",key)
            #endif
            print("KEY: ",key)
            request.setValue(key, forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response as? HTTPURLResponse else {
                    DispatchQueue.main.async {
                        completion(nil, 0)
                    }
                    return
                }
                
                DebugRequest(url, status: response, request: Data(), response: data)
                
                
                
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        if let key = key { UserDefaults.standard.set(data, forKey: key) }
                        completion(responseObject, response.statusCode)
                    }
                    //TODO
                } catch {
                    do {
                        _ = try decoder.decode(ErrorResponse.self, from: data) as Error
                        DispatchQueue.main.async {
                            completion(nil, response.statusCode)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(nil, response.statusCode)
                        }
                    }
                }
            }
            task.resume()
        }else{
            completion(nil,0)
        }
    }
    
    class func sendPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: String, responseType: ResponseType.Type, body: RequestType,header : Bool = false, httpMethod : httpMethod = .POST,noBody:Bool = false, completion: @escaping (ResponseType?,Int) -> ()) {
        let urlreq = URL(string: url)! //TODO guard
        var request = URLRequest(url: urlreq)
        request.httpMethod = httpMethod.rawValue
         
        let postData = try! JSONEncoder().encode(body)
        request.httpBody = noBody ? nil : postData
        
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if header {
            request.setValue(Defaults.token(), forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(nil, 0)
                }
                return
            }
            
            DebugRequest(url, status: response, request : postData, response : data)
            
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, response.statusCode)
                }
            } catch {
                //TODO
                do {
                    _ = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, 0)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, 0)
                    }
                }
            }
        }
        task.resume()
    }
}

