//
//  WidgetModel.swift
//  Enigma-WidgetExtension
//
//  Created by Aaryan Kothari on 08/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct WidgetModel : TimelineEntry {
    var date = Date()
    let user : UserDetails?
    let leaderboard : Leaderboard?
}
