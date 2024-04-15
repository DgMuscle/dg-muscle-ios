//
//  dg_muscle_ios_widget.swift
//  dg-muscle-ios-widget
//
//  Created by 신동규 on 10/15/23.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct dg_muscle_ios_widgetEntryView : View {
    
    var entry: Provider.Entry
    var datas: [WorkoutHeatMapViewModel.Data] = (try? FileManagerHelper.load([WorkoutHeatMapViewModel.Data].self, fromFile: .workoutHeatMapData)) ?? []

    var maxVolume: Double {
        datas.flatMap({ $0.volumes }).map({ $0.value }).max() ?? 0
    }

    var body: some View {
        if datas.isEmpty {
            Text("Data is Empty").fontWeight(.black)
        } else {
            HStack(alignment: .top, spacing: 4) {
                ForEach(datas) { data in
                    HeatMapColumnView(data: data, maxVolume: maxVolume)
                }
            }
        }
    }
}

struct dg_muscle_ios_widget: Widget {
    let kind: String = "dg_muscle_ios_widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            dg_muscle_ios_widgetEntryView(entry: entry)
                .containerBackground(.widgetBackground, for: .widget)
        }
        .supportedFamilies([.systemMedium])
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemMedium) {
    dg_muscle_ios_widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
