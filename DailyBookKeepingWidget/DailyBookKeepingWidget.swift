//
//  DailyBookKeepingWidget.swift
//  DailyBookKeepingWidget
//
//  Created by ext.jiayaning1 on 2023/2/13.
//

import WidgetKit
import SwiftUI
import HandyJSON

struct DailyBookProvider: TimelineProvider {
    func placeholder(in context: Context) -> DailyBookEntry {
        DailyBookEntry(date: Date(), money: "", items: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (DailyBookEntry) -> ()) {
        let entry = DailyBookEntry(date: Date(), money: "", items: [])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        
        let userDefault = UserDefaults.init(suiteName: "group.com.dailybook")
        let items = userDefault?.object(forKey: "items") as! Array<[String : Any]>
        let totalMoney = userDefault?.object(forKey: "totalMoney") as! String
        
        var models: [HomeCategoryItemModel] = []
        
        for item in items {
            if let model = HomeCategoryItemModel.deserialize(from: item) {
                models.append(model)
            }
        }
        
        let entry = DailyBookEntry(date: Date(), money: totalMoney, items: models)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            completion(timeline)
        }
    }
}

struct DailyBookEntry: TimelineEntry {
    let date: Date
    var money: String = ""
    var items: [HomeCategoryItemModel] = []
}

struct DailyBookKeepingWidgetEntryView : View {
    var entry: DailyBookProvider.Entry
    
    @Environment(\.widgetFamily) var family: WidgetFamily;
    
    var body: some View {
        if entry.items.count != 0 {
            VStack(spacing: 0) {
                HStack(alignment: .lastTextBaseline, spacing: 0){
                    Text("今年")
                        .font(Font.chineseFont(size: 14))
                        .frame(height: 16)
                    Spacer()
                    MoneyView(money: entry.money, hasNegative: true, font1: 12, font2: 15, font3: 10)
                        .frame(height: 16)
                }
                .padding(EdgeInsets.init(top: 10, leading: 12, bottom: 6, trailing: 12))
                .background(LinearGradient(gradient: .init(colors: [Color.init(red: 51/255.0, green: 52/255.0, blue: 86/255.0),Color.init(red: 61/255.0, green: 62/255.0, blue: 96/255.0)]), startPoint: UnitPoint(x: 0, y: 0), endPoint: UnitPoint(x: 0, y: 1)))
                Spacer()
                    .frame(maxHeight: 15)
                HStack(spacing: 10) {
                    if entry.items.count >= 4 {
                        ItemView(model: entry.items[0])
                        ItemView(model: entry.items[1])
                        ItemView(model: entry.items[2])
                        ItemView(model: entry.items[3])
                    }
                    if entry.items.count == 3 {
                        ItemView(model: entry.items[0])
                        ItemView(model: entry.items[1])
                        ItemView(model: entry.items[2])
                    }
                    if entry.items.count == 2 {
                        ItemView(model: entry.items[0])
                        ItemView(model: entry.items[1])
                    }
                    if entry.items.count == 1 {
                        ItemView(model: entry.items[0])
                    }
                }
                .shadow(color: Color.init(white: 0, opacity: 0.2), radius: 1)
                Spacer()
                    .frame(minHeight: 0)
            }
            .foregroundColor(.white)
            .background(Color.init(red: 51/255.0, green: 52/255.0, blue: 86/255.0))
        }else {
            EmptyView()
        }
    }
}

// item视图
struct ItemView: View {
    
    var model = HomeCategoryItemModel()
    
    var body: some View {
        VStack() {
            Text(model.categoryName ?? "")
                .font(Font.chineseFont(size: 14))
            Spacer()
                .frame(minHeight: 0)
            Text(model.categoryIcon ?? "")
                .font(Font.system(size: 22))
            Spacer()
                .frame(minHeight: 0)
            MoneyView(money: model.money, font1: 9, font2: 12, font3: 9)
        }
        .frame(width: 70, height: 78)
        .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
//        .background(Color.init(uiColor: UIColor.color(fromHexString: model?.categoryColor)))
        .cornerRadius(12)
    }
}

// 空组件
struct EmptyView: View {
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("这里还没有数据~")
                    .font(Font.jdBoldFont(size: 14))
                Spacer()
            }
            Spacer()
        }
        .foregroundColor(.white)
        .background(Color.init(red: 51/255.0, green: 52/255.0, blue: 86/255.0))
    }
}

// 金钱
struct MoneyView: View {
    
    var money: String?
    var hasNegative: Bool?
    var attributeString: AttributedString?
    var font1: CGFloat?
    var font2: CGFloat?
    var font3: CGFloat?
    
    init(money: String? = nil, hasNegative: Bool? = false, attributeString: AttributedString? = nil, font1: CGFloat? = 10, font2: CGFloat? = 12, font3: CGFloat? = 10) {
        self.money = money
        self.attributeString = attributeString
        
        var first = "0"
        var last = ".00"
        
        if money != nil && money!.count > 0 {
            
            let regular = try? NSRegularExpression(pattern: "^[0-9.]*$", options: .caseInsensitive)
            let matchs = regular?.matches(in: money!, options: .reportProgress, range: NSRange(location: 0, length: money!.count))
            if (matchs?.count)! > 0 {
                let array = money!.components(separatedBy: ".")
                if array.count == 2 {
                    let item1 = array[0]
                    var isAdd = false
                    if item1.count > 0 {
                        if UInt(item1)! > 0 {
                            isAdd = true
                            first = (NSString.init(format: "%ld", UInt(item1)!) as String)
                            if hasNegative! {
                                first = "-" + first
                            }
                        }
                    }
                    var item2 = array[1]
                    if item2.count > 0 {
                        if !isAdd {
                            if hasNegative! && UInt(first)! > 0 {
                                first = "-0"
                            }
                        }
                        if item2.count == 1 {
                            item2 = item2 + "0"
                        }
                        if item2.count > 2 {
                            item2 = (item2 as NSString).substring(with: NSRange(location: 0, length: 2))
                        }
                        last = "." + item2
                    }
                }else if array.count == 1 {
                    let item = array[0]
                    if item.count > 0 {
                        if Int32(item)! > 0 {
                            first = (NSString.init(format: "%ld", Int32(item)!) as String)
                            if hasNegative! {
                                first = "-" + first
                            }
                        }
                    }
                }
            }
        }
        var att1 = AttributedString("￥")
        att1.font = Font.jdBoldFont(size: font1!)
        var att2 = AttributedString(first)
        att2.font = Font.jdBoldFont(size: font2!)
        var att3 = AttributedString(last)
        att3.font = Font.jdBoldFont(size: font3!)
        self.attributeString = att1 + att2 + att3
    }
    
    var body: some View {
        HStack {
            Text(attributeString!)
                .minimumScaleFactor(0.01)
        }
        .foregroundColor(.white)
    }
}

struct DailyBookKeepingWidget: Widget {
    let kind: String = "DailyBookKeepingWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: DailyBookProvider()) { entry in
            DailyBookKeepingWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemMedium])
    }
}

struct DailyBookKeepingWidgetPreview: PreviewProvider {
    static var previews: some View {
        DailyBookKeepingWidgetEntryView(entry: DailyBookEntry(date: Date()))
            .previewContext(WidgetPreviewContext.init(family: .systemMedium))
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
