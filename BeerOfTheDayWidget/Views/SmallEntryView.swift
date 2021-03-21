//
//  SmallEntryView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 20.03.2021.
//

import SwiftUI
import WidgetKit

struct SmallEntryView: View {
    let beers: [WidgetBeerInfo]
    
    var image: UIImage? {
        guard let beer = beers.first else { return nil }
        return WidgetManager.image(for: beer)
    }
    
    var body: some View {
        VStack(alignment: .center) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            if let beer = beers.first {
                Text(beer.name)
                    .lineLimit(2)
                    .font(WidgetFont.title)
                    .foregroundColor(WidgetColor.text)
                    .lineSpacing(1.5)
            }
        }
        .padding()
        .widgetURL(WidgetManager.widgetURL(for: beers.first))
    }
}

struct SmallEntryView_Previews: PreviewProvider {
    static var previews: some View {
        SmallEntryView(beers: WidgetManager.samples)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
