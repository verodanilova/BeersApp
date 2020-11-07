//
//  UITableView+Extensions.swift
//  BeersApp
//
//  Created by Veronica Danilova on 02.11.2020.
//

import UIKit


extension UITableView {
    func registerCell(_ identifier: String, _ nibName: String, _ bundle: Bundle? = nil) {
        let nib = UINib(nibName: nibName, bundle: bundle)
        self.register(nib, forCellReuseIdentifier: identifier)
    }
}
