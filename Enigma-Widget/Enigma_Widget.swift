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
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationIntent
}

struct Enigma_WidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) private var family
    @State var token : String?

    var body: some View {
        Group {
            switch family {
            case .systemSmall:
                SmallWidget()
            case .systemMedium:
                SmallWidget()
            case .systemLarge:
                SmallWidget()
            @unknown default:
                SmallWidget()
            }
        }
    }
    
    func getData(){
        let defaults = UserDefaults(suiteName: "group.widget.ak")
        defaults?.synchronize()
        self.token = defaults?.string(forKey: "token")
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

struct Enigma_Widget_Previews: PreviewProvider {
    static var previews: some View {
        Enigma_WidgetEntryView(entry: SimpleEntry(date: Date(), configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
