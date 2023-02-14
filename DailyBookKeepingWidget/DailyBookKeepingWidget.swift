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
    
    let edges: EdgeInsets = EdgeInsets.init(top: 15, leading: 0, bottom: 15, trailing: 0)
    let itemColor: Color = Color.init(red: 51/255.0, green: 53/255.0, blue: 86/255.0)
    let radius: CGFloat = 10.0
    let itemWidth: CGFloat = 70
    
    @Environment(\.widgetFamily) var family: WidgetFamily;
    
    var body: some View {
        switch(family) {
        case .systemMedium:
            VStack{
                HStack(spacing: 0) {
                    Spacer()
                        .frame(width: 2)
                    Text("今年")
                        .font(.chineseFont(size: 16))
                        .foregroundColor(Color.white)
                        .italic()
                    Spacer()
                    HStack(alignment: .lastTextBaseline, spacing: 2){
                        Text("支")
                            .font(.chineseFont(size: 12))
                            .offset(x: 0, y: -0.4)
                        Text("￥")
                            .font(.chineseFont(size: 10))
                            .offset(x: 0, y: -0.4)
                        HStack(alignment: .lastTextBaseline, spacing: 0) {
                            Text("0")
                                .font(.jdBoldFont(size: 20))
                            Text(".")
                                .font(.jdBoldFont(size: 10))
                            Text("00")
                                .font(.jdBoldFont(size: 10))
                        }
                    }
                }
                .foregroundColor(Color.white)
                Spacer()
                    .frame(height: 10)
                VStack{
                    Spacer()
                        .frame(height: 0)
                    HStack(spacing: 0) {
                        VStack(spacing: 12) {
                            Text("餐饮")
                                .font(.chineseFont(size: 13))
                                .foregroundColor(Color.white)
                            Text("🍜")
                                .font(.system(size: 18))
                            HStack(alignment: .lastTextBaseline, spacing: 0){
                                Text("￥")
                                    .font(.jdBoldFont(size: 8))
                                    .foregroundColor(Color.white)
                                + Text("99999")
                                    .font(.jdBoldFont(size: 12))
                                    .foregroundColor(Color.white)
                                + Text(".45")
                                    .font(.jdBoldFont(size: 8))
                                    .foregroundColor(Color.white)
                            }
                        }
                        .frame(width: itemWidth)
                        .padding(edges)
                        .background(itemColor)
                        .cornerRadius(radius)
                        Spacer()
                            .frame(minWidth: 0)
                        VStack(spacing: 12) {
                            Text("交通")
                                .font(.chineseFont(size: 13))
                                .foregroundColor(Color.white)
                            Text("🚕")
                                .font(.system(size: 18))
                            HStack(alignment: .lastTextBaseline, spacing: 0){
                                Text("￥")
                                    .font(.jdBoldFont(size: 8))
                                    .foregroundColor(Color.white)
                                + Text("99999")
                                    .font(.jdBoldFont(size: 12))
                                    .foregroundColor(Color.white)
                                + Text(".45")
                                    .font(.jdBoldFont(size: 8))
                                    .foregroundColor(Color.white)
                            }
                        }
                        .frame(width: itemWidth)
                        .padding(edges)
                        .background(itemColor)
                        .cornerRadius(radius)
                        Spacer()
                            .frame(minWidth: 0)
                        VStack(spacing: 12) {
                            Text("购物")
                                .font(.chineseFont(size: 13))
                                .foregroundColor(Color.white)
                            Text("🛍")
                                .font(.system(size: 18))
                            ItemView()
                        }
                        .frame(width: itemWidth)
                        .padding(edges)
                        .background(itemColor)
                        .cornerRadius(radius)
                        Spacer()
                            .frame(minWidth: 0)
                        VStack(spacing: 12) {
                            Text("娱乐")
                                .font(.chineseFont(size: 13))
                                .foregroundColor(Color.white)
                            Text("🤹‍♂️")
                                .font(.system(size: 18))
                            HStack(alignment: .lastTextBaseline, spacing: 0){
                                Text("￥")
                                    .font(.jdBoldFont(size: 8))
                                    .foregroundColor(Color.white)
                                + Text("999")
                                    .font(.jdBoldFont(size: 12))
                                    .foregroundColor(Color.white)
                                + Text(".45")
                                    .font(.jdBoldFont(size: 8))
                                    .foregroundColor(Color.white)
                            }
                        }
                        .frame(width: itemWidth)
                        .padding(edges)
                        .background(itemColor)
                        .cornerRadius(radius)
                        Spacer()
                            .frame(width: 0)
                    }
                    Spacer()
                        .frame(minHeight: 0)
                }
                .padding(0)
            }
            .padding(EdgeInsets.init(top: 10, leading: 15, bottom: 10, trailing: 15))
            .background(LinearGradient(gradient: Gradient(colors: [Color.init(red: 91/255.0, green: 93/255.0, blue: 126/255.0), Color.init(red: 76/255.0, green: 78/255.0, blue: 112/255.0), Color.init(red: 91/255.0, green: 93/255.0, blue: 126/255.0)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
        default:
            Text("")
        }
    }
}

struct ItemView: View {
    var body: some View {
        HStack(alignment: .lastTextBaseline, spacing: 0){
            Text("￥")
                .font(.jdBoldFont(size: 8))
                .foregroundColor(Color.white)
            + Text("999")
                .font(.jdBoldFont(size: 12))
                .foregroundColor(Color.white)
            + Text(".45")
                .font(.jdBoldFont(size: 8))
                .foregroundColor(Color.white)
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
