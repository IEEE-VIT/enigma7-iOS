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
    
    class func sendGETRequest<ResponseType: Decodable>(url: String,parameters : [String:String],responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?) -> Void) {
        var components = URLComponents(string: url)!
        components.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        if let requestURL = components.url {
            var request = URLRequest(url: requestURL)
            request.setValue(Defaults.token(), forHTTPHeaderField: "Authorization")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else  {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(ResponseType.self, from: data)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                } catch {
                    do {
                        let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                        DispatchQueue.main.async {
                            completion(nil, errorResponse)
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(nil, error)
                        }
                    }
                }
            }
            task.resume()
        }else{
            completion(nil,nil)
        }
    }
    
    class func sendPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: String, responseType: ResponseType.Type, body: RequestType,header : Bool = false, httpMethod : httpMethod = .POST,completion: @escaping (ResponseType?, Error?) -> ()) {
        let urlreq = URL(string: url)!
        var request = URLRequest(url: urlreq)
        request.httpMethod = httpMethod.rawValue
        let postData = try! JSONEncoder().encode(body)
        
        request.httpBody = postData
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if header {
            request.setValue(Defaults.token(), forHTTPHeaderField: "Authorization")
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            DebugRequest(url, request : postData, response : data)
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do {
                    let errorResponse = try decoder.decode(ErrorResponse.self, from: data) as Error
                    DispatchQueue.main.async {
                        completion(nil, errorResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
}

