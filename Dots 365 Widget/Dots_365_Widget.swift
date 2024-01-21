//
//  Dots_365_Widget.swift
//  Dots 365 Widget
//
//  Created by Ray on 1/20/24.
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

struct Dots_365_WidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    let calendar = Calendar.current.dateComponents([.year, .month, .day], from: .now)
    let daysOfYear = daysInMonths().reduce(0, +)
    let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: .now)!
    

    var body: some View {
        switch family {
// MARK: Medium
        case .systemMedium:
            GeometryReader(content: { geometry in
                let dotSize = geometry.size.width / (31+30-2)
                
                VStack(spacing: 8) {
                    HStack() {
                        Text(String(calendar.year!))
                            .font(.title)
                            .fontWeight(.black)
                            .fontWidth(.expanded)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text("\(dayOfYear)/\(daysOfYear)")
                                .fontDesign(.monospaced)
                                .foregroundStyle(.gray)
                                .padding(.trailing)
                            Text("\(Int((Double(dayOfYear) / Double(daysOfYear) * 100)))")
                                .font(.title)
                                .fontWeight(.black)
                            Text("%")
                                .font(.title3)
                                .fontWidth(.condensed)
                                .fontWeight(.black)
                        }
                        .frame( alignment: .trailing)
                    }
                    
                    VStack(spacing: dotSize) {
                        ForEach(1..<12, id: \.self) { month in
                            HStack(spacing: dotSize) {
                                ForEach(1..<daysInMonths()[month-1], id: \.self) { day in
                                    switch true {
                                    case month <= calendar.month! && day < calendar.day!:
                                        Circle()
                                            .frame(width: dotSize)
                                            .foregroundColor(Color("Dot").opacity(1))
                                    case month == calendar.month! && day == calendar.day!:
                                        Circle()
                                            .frame(width: dotSize)
                                            .foregroundColor(.red)
                                            .scaleEffect(1.6)
                                            .shadow(color: .red.opacity(0.5), radius: 1)
                                    default:
                                        Circle()
                                            .frame(width: dotSize)
                                            .foregroundColor(Color("Dot").opacity(0.25))
                                            .scaleEffect(0.75)
                                    }
                                }
                                
                            }
                            .frame(width: geometry.size.width, alignment: .leading)
    //                        .background(.green)
                        }
                    }
    //                .background(.yellow)
                }
    //            .background(.green)
            })
// MARK: Small
        default:
            GeometryReader(content: { geometry in
                let dotSize = geometry.size.width / (31+30-2)
                
                VStack(spacing: 8) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(String(calendar.year!))
                            .foregroundStyle(.red)
                        Spacer()
                        Text("\(Int((Double(dayOfYear) / Double(daysOfYear) * 100)))%")
                    }
                    .fontWidth(.expanded)
                    .fontWeight(.bold)
                    

                    VStack(spacing: dotSize) {
                        ForEach(1..<12, id: \.self) { month in
                            HStack(spacing: dotSize) {
                                ForEach(1..<daysInMonths()[month-1], id: \.self) { day in
                                    switch true {
                                    case month <= calendar.month! && day < calendar.day!:
                                        Circle()
                                            .frame(width: dotSize)
                                            .foregroundColor(Color("Dot").opacity(1))
                                    case month == calendar.month! && day == calendar.day!:
                                        Circle()
                                            .frame(width: dotSize)
                                            .foregroundColor(.red)
                                            .scaleEffect(1.6)
                                            .shadow(color: .red.opacity(0.5), radius: 1)
                                    default:
                                        Circle()
                                            .frame(width: dotSize)
                                            .foregroundColor(Color("Dot").opacity(0.25))
                                            .scaleEffect(0.75)
                                    }
                                }
                                
                            }
                            .frame(width: geometry.size.width, alignment: .leading)
                        }
                    }
                    .padding([.vertical], 10)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text("\(dayOfYear)/\(daysOfYear)")
                            .font(.system(size: 10, weight: .light))
                            .fontDesign(.monospaced)
                            .foregroundStyle(.gray)
                    }
                    .frame( alignment: .bottom)
//                    .background(.yellow)
                }
                .frame(maxHeight: .infinity)
//                .background(.green)
            })

        }
        

        
    }
}

struct Dots_365_Widget: Widget {
    let kind: String = "Dots_365_Widget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            Dots_365_WidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([
            .systemSmall,
            .systemMedium
        ])
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

#Preview(as: .systemSmall) {
    Dots_365_Widget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
//    SimpleEntry(date: .now, configuration: .starEyes)
}
