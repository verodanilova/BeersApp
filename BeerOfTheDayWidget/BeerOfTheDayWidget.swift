//
//  BeerOfTheDayWidget.swift
//  BeerOfTheDayWidget
//
//  Created by Veronica Danilova on 20.03.2021.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> BeerEntry {
        BeerEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (BeerEntry) -> ()) {
        let entry = BeerEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let entries = [BeerEntry(date: Date())]
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct BeerEntry: TimelineEntry {
    let date: Date
}

struct BeerOfTheDayWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
            case .systemSmall:
                SmallEntryView(beers: WidgetBeerInfo.samples)
            case .systemMedium:
                MediumEntryView(beers: WidgetBeerInfo.samples)
            case .systemLarge:
                LargeEntryView(beers: WidgetBeerInfo.samples)
            @unknown default:
                SmallEntryView(beers: WidgetBeerInfo.samples)
        }
    }
}

@main
struct BeerOfTheDayWidget: Widget {
    let kind: String = "BearOfTheDayWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            BeerOfTheDayWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Beer of the day")
        .description("Widget description")
    }
}

struct BeerOfTheDayWidget_Previews: PreviewProvider {
    static var previews: some View {
        BeerOfTheDayWidgetEntryView(entry: BeerEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
