//
//  DailyBookKeepingWidget.swift
//  DailyBookKeepingWidget
//
//  Created by ext.jiayaning1 on 2023/2/13.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct DailyBookKeepingWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family: WidgetFamily;
    
    var body: some View {
        switch(family) {
        case .systemMedium:
            VStack{
                HStack(spacing: 0) {
                    Text("本年")
                        .font(Font.system(size: 14))
                        .foregroundColor(Color.white)
                        .fontWeight(Font.Weight.semibold)
                    Spacer()
                    Text("支")
                        .font(Font.system(size: 10, weight: Font.Weight.semibold))
                        .foregroundColor(Color.white)
                        .frame(height: 10, alignment: .top)
                    HStack(alignment: .lastTextBaseline, spacing: 0){
                        Text("￥")
                            .font(Font.system(size: 11, weight: Font.Weight.semibold))
                            .foregroundColor(Color.white)
                        Text("2381")
                            .font(Font.system(size: 16, weight: Font.Weight.semibold))
                            .foregroundColor(Color.white)
                        Text(".36")
                            .font(Font.system(size: 11, weight: Font.Weight.semibold))
                            .foregroundColor(Color.white)
                    }
                }
                Spacer()
                HStack{
                    Text("支￥2381.11")
                }
                Spacer()
            }
            .padding(EdgeInsets.init(top: 10, leading: 15, bottom: 10, trailing: 15))
            .background(Color.orange)
        default:
            Text("")
        }
    }
}

struct DailyBookKeepingWidget: Widget {
    let kind: String = "DailyBookKeepingWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            DailyBookKeepingWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}
