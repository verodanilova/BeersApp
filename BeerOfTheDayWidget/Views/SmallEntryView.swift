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
    
    let image = UIImage(named: "defaultImage")
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            if let beer = beers.first {
                Text(beer.name)
                    .lineLimit(2)
                    .font(WidgetFont.title)
                    .foregroundColor(.white)
                    .lineSpacing(1.5)
            }
        }
        .padding()
        .background(BackgroundImage(image: image))
    }
}

struct SmallEntryView_Previews: PreviewProvider {
    static var previews: some View {
        SmallEntryView(beers: WidgetBeerInfo.samples)
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
