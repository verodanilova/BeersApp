//
//  String+Extensions.swift
//  BeersApp
//
//  Created by Veronica Danilova on 22.03.2021.
//

extension String {
    func toQuery() -> String {
        self.replacingOccurrences(of: " ", with: "+")
    }
}
