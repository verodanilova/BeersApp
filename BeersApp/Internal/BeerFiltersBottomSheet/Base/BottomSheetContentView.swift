//
//  BottomSheetContentView.swift
//  BeersApp
//
//  Created by Veronica Danilova on 08.11.2020.
//

import UIKit


private struct Constants {
    let roundingCorners: UIRectCorner = [.topLeft, .topRight]
    let cornerRadii = CGSize(width: 16, height: 16)
}
private let constants = Constants()

class BottomSheetContentView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()

        let maskFrame = CGRect.init(x: 0, y: 0,
            width: frame.width, height: frame.height)
        let maskPath = UIBezierPath(roundedRect: maskFrame,
            byRoundingCorners: constants.roundingCorners,
            cornerRadii: constants.cornerRadii)
                
        let maskLayer = CAShapeLayer()
        maskLayer.frame = maskFrame
        maskLayer.path = maskPath.cgPath

        layer.mask = maskLayer
    }
}
