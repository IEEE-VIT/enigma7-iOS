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
        WidgetModel(user: Defaults.Widgetuser())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (WidgetModel) -> ()) {
        let entry =  WidgetModel(user: nil)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<WidgetModel>) -> ()) {
        var entries: [WidgetModel] = []
        
        
        let refresh = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()

        
        sessionStore.fetchUser { user in
            entries.append(WidgetModel(user: user))
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
            switch family {
            case .systemSmall:
                SmallWidget(data: entry.user)
            case .systemMedium:
                SmallWidget()
            case .systemLarge:
                SmallWidget()
            @unknown default:
                SmallWidget()
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
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}
