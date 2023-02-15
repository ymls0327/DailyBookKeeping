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
        Text("123")
    }
}

// 金钱
struct ItemView: View {
    
    let money_overall: String
    let money_decimals: String
    let small_font: CGFloat
    let lager_font: CGFloat
    
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 0){
            Text("￥")
                .font(.jdBoldFont(size: small_font))
            + Text(money_overall)
                .font(.jdBoldFont(size: lager_font))
                .foregroundColor(Color.white)
            + Text(".")
                .font(.jdBoldFont(size: small_font))
            + Text(money_decimals)
                .font(.jdBoldFont(size: small_font))
        }
        .foregroundColor(Color.white)
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

extension Font {
    static func jdRegularFont(size: CGFloat) -> Font {
        return Font.custom("JDZhengHT-Regular", size: size)
    }
    static func jdBoldFont(size: CGFloat) -> Font {
        return Font.custom("JDLANGZHENGTI-SB--GBK1-0", size: size)
    }
    static func chineseFont(size: CGFloat) -> Font {
        return Font.custom("AppleTsukuBRdGothic-Bold", size: size)
    }
}
