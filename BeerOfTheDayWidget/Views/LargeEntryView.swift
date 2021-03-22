//
//  LargeEntryView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 20.03.2021.
//

import SwiftUI
import WidgetKit

struct LargeEntryView: View {
    let beers: [WidgetBeerInfo]

    var body: some View {
        VStack(spacing: 0) {
            if let beer = beers.first {
                if let url = WidgetManager.widgetURL(for: beer) {
                    Link(destination: url, label: {
                        TopBeerInfoView(beer: beer)
                    })
                } else {
                    TopBeerInfoView(beer: beer)
                }
                Separator().padding()
            }
            VStack {
                if beers.count > 1, let beer = beers[1] {
                    if let url = WidgetManager.widgetURL(for: beer) {
                        Link(destination: url, label: {
                            BeerInfoView(beer: beer)
                        })
                    } else {
                        BeerInfoView(beer: beer)
                    }
                }
                if beers.count > 2, let beer = beers[2] {
                    SeparatorWithInsets()
                    if let url = WidgetManager.widgetURL(for: beer) {
                        Link(destination: url, label: {
                            BeerInfoView(beer: beer)
                        })
                    } else {
                        BeerInfoView(beer: beer)
                    }
                }
            }
            .padding()
        }
        .background(WidgetColor.background)
    }
}

struct LargeEntryView_Previews: PreviewProvider {
    static var previews: some View {
        LargeEntryView(beers: WidgetManager.samples)
            .previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}

