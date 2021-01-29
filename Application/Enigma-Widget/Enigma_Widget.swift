//
//  Enigma_Widget.swift
//  Enigma-Widget
//
//  Created by Aaryan Kothari on 08/10/20.
//  Copyright © 2020 Aaryan Kothari. All rights reserved.
//

import WidgetKit
import SwiftUI
import Intents

struct Provider: IntentTimelineProvider {
    
    /// SESSION STORE IS OBSERVABLE OBJECT MADE USING COMBINE
    @ObservedObject var sessionStore = SessionStore()
    
    
    func placeholder(in context: Context) -> WidgetModel {
        WidgetModel(user: Defaults.user(), question: Defaults.question(),isLogin:Defaults.token() != "")
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetModel) -> ()) {
        let entry =  WidgetModel(user: nil, question: Defaults.question(),isLogin:Defaults.token() != "")
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WidgetModel>) -> ()) {
        var entries: [WidgetModel] = []
        
        
        let refresh = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()

        
        sessionStore.fetchUser { user in
            entries.append(WidgetModel(user: user, question: Defaults.question(),isLogin:Defaults.token() != ""))
            let timeline = Timeline(entries: entries, policy: .after(refresh))
            completion(timeline)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct Enigma_WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var family

    var body: some View {
        Group {
            if family == .systemSmall{
                SmallWidget(data: entry.user)
            } else {
                LargeWidget(entry: entry)
            }
        }
    }
}

@main
struct Enigma_Widget: Widget {
    let kind: String = "Enigma_Widget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            Enigma_WidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Enigma Widget")
        .description("Get your profile and questions right from your widgets!")
        .supportedFamilies([.systemSmall,.systemLarge])
    }
}
