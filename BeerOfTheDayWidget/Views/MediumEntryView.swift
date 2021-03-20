//
//  MediumEntryView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 20.03.2021.
//

import SwiftUI
import WidgetKit

struct MediumEntryView: View {
    let beers: [WidgetBeerInfo]

    var body: some View {
        VStack {
            if beers.count > 1 {
                ForEach(beers.prefix(2), id: \.self) { beer in
                    BeerInfoView(beer: beer)
                    if beer.id == beers.prefix(2).first?.id {
                        SeparatorWithInsets()
                    }
                }
            }
        }
        .padding()
        .background(WidgetColor.background)
    }
}

struct MediumEntryView_Previews: PreviewProvider {
    static var previews: some View {
        MediumEntryView(beers: WidgetBeerInfo.samples)
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
