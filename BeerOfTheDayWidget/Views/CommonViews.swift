//
//  CommonViews.swift
//  BeersApp
//
//  Created by Veronica Danilova on 20.03.2021.
//

import SwiftUI

struct BackgroundImage: View {
    var image: UIImage?
    
    var body: some View {
        if let image = image {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(OverlayView())
        } else {
            OverlayView()
        }
    }
}

struct OverlayView: View {
    let gradient = Gradient(colors: [
        WidgetColor.backgroundGradientTop,
        WidgetColor.backgroundGradientBottom
    ])
    
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .background(LinearGradient(gradient: gradient,
                startPoint: .top, endPoint: .bottom))
    }
}

struct TopBeerInfoView: View {
    let beer: WidgetBeerInfo
    
    let image = UIImage(named: "defaultImage")
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 120, height: 120)
                    .cornerRadius(8.0)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(beer.name)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(WidgetFont.accentedText)
                    .foregroundColor(WidgetColor.text)
                    .lineSpacing(1.5)
                Text(beer.description)
                    .lineLimit(5)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(WidgetFont.text)
                    .foregroundColor(WidgetColor.text)
                    .lineSpacing(1.5)
            }
            Spacer()
        }
        .padding()
    }
}

struct BeerInfoView: View {
    let beer: WidgetBeerInfo
    
    let image = UIImage(named: "defaultImage")
    
    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 56, height: 56)
                    .cornerRadius(8.0)
            }
            VStack(alignment: .leading, spacing: 4) {
                Text(beer.name)
                    .lineLimit(1)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(WidgetFont.accentedText)
                    .foregroundColor(WidgetColor.text)
                    .lineSpacing(1.5)
                Text(beer.description)
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(WidgetFont.text)
                    .foregroundColor(WidgetColor.text)
                    .lineSpacing(1.5)
            }
            Spacer()
        }
    }
}

struct Separator: View {

    var body: some View {
        Rectangle()
            .foregroundColor(WidgetColor.separator)
            .frame(idealWidth: .infinity, maxWidth: .infinity,
                minHeight: 1, idealHeight: 1, maxHeight: 1)
    }
}

struct SeparatorWithInsets: View {
    private let insets = EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0)
    
    var body: some View {
        Separator()
            .padding(insets)
    }
}
