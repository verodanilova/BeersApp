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
                TopBeerInfoView(beer: beer)
                Separator().padding()
            }
            VStack {
                if beers.count > 1, let beer = beers[1] {
                    BeerInfoView(beer: beer)
                }
                if beers.count > 2, let beer = beers[2] {
                    SeparatorWithInsets()
                    BeerInfoView(beer: beer)
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

