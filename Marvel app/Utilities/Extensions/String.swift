//
//  String.swift
//  Marvel app
//
//  Created by Salvador on 4/3/23.
//

import Foundation

extension String {
    var https: String {
        let http = self
        var comps = URLComponents(string: http)!
        comps.scheme = "https"
        return comps.string!
    }
    
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
