//
//  GameTests.swift
//  EnigmaTests
//
//  Created by Aaryan Kothari on 05/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import XCTest
@testable import Enigma

class GameTests: XCTestCase {

    // custom urlsession for mock network calls
    var urlSession: URLSession!

    override func setUpWithError() throws {
        // Set url session for mock networking
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        
        // set temp keychain token
        // api calls require a token, otherwise tests fail
        UserDefaults.standard.setValue("", forKey: Keys.token)
    }

    override func tearDownWithError() throws {
        urlSession = nil
        UserDefaults.standard.setValue("", forKey: Keys.token)
        super.tearDown()
    }
    
    func testLeaderboard() {
        // given
        let url = URL(string: NetworkConstants.Game.leaderboardURL)
        // 1
        let promise = expectation(description: "Status code: 200")

        // when
        let dataTask = urlSession.dataTask(with: url!) { data, response, error in
          // then
          if let error = error {
            XCTFail("Error: \(error.localizedDescription)")
            return
          } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            if statusCode == 200 {
              // 2
              promise.fulfill()
            } else {
              XCTFail("Status code: \(statusCode)")
            }
          }
        }
        dataTask.resume()
        // 3
        wait(for: [promise], timeout: 5)
    }

}
