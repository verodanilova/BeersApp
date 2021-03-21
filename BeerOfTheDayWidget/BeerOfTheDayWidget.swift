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
        BeerEntry(date: Date(), beers: WidgetManager.samples)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (BeerEntry) -> ()) {
        let entry = BeerEntry(date: Date(), beers: WidgetManager.samples)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let manager = WidgetManager()
        manager.loadBeerEntries { entries in
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
    }
}

struct BeerEntry: TimelineEntry {
    let date: Date
    let beers: [WidgetBeerInfo]
}

struct BeerOfTheDayWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family
    
    @ViewBuilder
    var body: some View {
        switch family {
            case .systemSmall:
                SmallEntryView(beers: entry.beers)
            case .systemMedium:
                MediumEntryView(beers: entry.beers)
            case .systemLarge:
                LargeEntryView(beers: entry.beers)
            @unknown default:
                SmallEntryView(beers: entry.beers)
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
        .description("Your alco companion for the evening")
    }
}

struct BeerOfTheDayWidget_Previews: PreviewProvider {
    static var previews: some View {
        BeerOfTheDayWidgetEntryView(entry: BeerEntry(date: Date(), beers: WidgetManager.samples))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
