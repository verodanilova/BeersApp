//
//  UIImageView+Loading.swift
//  BeersApp
//
//  Created by Veronica Danilova on 07.11.2020.
//

import UIKit
import Kingfisher


extension UIImageView {
    func setImage(from imageURL: URL?, placeholder: UIImage? = nil) {
        self.kf.indicatorType = .activity
        self.kf.setImage(
            with: imageURL,
            placeholder: placeholder,
            options: [
                .transition(.fade(0.4)),
                .cacheOriginalImage
            ])
    }
}
