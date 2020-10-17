//
//  SessionStore.swift
//  Enigma-WidgetExtension
//
//  Created by Aaryan Kothari on 08/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import Foundation
import Combine

final class SessionStore: ObservableObject {
    @Published  var user : UserDetails?
    @Published  var leaderboard : Leaderboard?

    init(){
        self.fetchUser { _ in }
    }
}

extension SessionStore{
    func fetchUser(completion : @escaping(UserDetails?)->()){
        ServiceController.shared.getUserDetails(w: true){
            print("USER:",$0)
            self.user = $0
            completion($0)
        }
    }
}
